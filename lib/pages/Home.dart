import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gan/services/AdService.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/widgets/HomePost.dart';
import 'package:gan/widgets/MyNavigationBar.dart';
import 'package:gan/widgets/TopBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchBarController = TextEditingController();
  List<HomePost> _postWidgets = [];
  Timer? _debounce;

  @override
  void initState() {
    loadPosts();
    super.initState();
    searchBarController.addListener(_onSearchChanged);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        loadPosts();
      }
    });
  }

  void loadPosts() async {
    try {
      final snapshot = await AuthService.db
          .collection("posts")
          .orderBy('timestamp', descending: true)
          .get();

      if (snapshot.docs.isEmpty) {
        print("No posts found");
        return;
      }

      final posts = snapshot.docs.map((doc) => doc.data()).take(5).toList();

      setState(() {
        _postWidgets.addAll(posts.map((p) => HomePost(postData: p)));
      });
    } catch (e) {
      print("Error loading posts: $e");
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      search();
    });
  }

  void search() async {
    String query = searchBarController.text.trim().toLowerCase();

    if (query.isEmpty) {
      print("Search bar is empty.");
      loadPosts();
      return;
    }

    print("Searching for: $query");

    final ref = AuthService.db.collection("posts");

    try {
      final snapshot = await ref.get();

      final postList = snapshot.docs
          .map((doc) => doc.data())
          .where((data) {
        final title = (data['title'] ?? '').toString().toLowerCase();
        final content = (data['content'] ?? '').toString().toLowerCase();
        return title.contains(query) || content.contains(query);
      })
          .toList();

      setState(() {
        _postWidgets = postList.map((p) => HomePost(postData: p)).toList();
      });

    } catch (e) {
      print("Error during search: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Scrollbar(
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 100,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _postWidgets,
                        ),
                      ),
                    ),
                  ),
                  MyNavigationBar(),
                  TopBar(
                    isMiddleSearchBar: true,
                    searchBarController: searchBarController,
                    rightIcon: Icons.post_add,
                    rightIcon_onTap: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        "/CreatePost",
                      );
                      if (result == 'postCreated') {
                        setState(() {
                          _postWidgets.clear();
                        });
                        loadPosts();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
