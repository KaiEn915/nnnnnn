import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/utils/OurUI.dart';
import 'package:gan/widgets/HomePost.dart';
import 'package:gan/widgets/MyNavigationBar.dart';
import 'package:gan/widgets/OurFont.dart';
import 'package:gan/widgets/TopBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchBarController = TextEditingController();
  List<String> _loadedPostIds = [];
  Timer? _debounce;

  @override
  void initState() {
    loadPosts();
    super.initState();
    searchBarController.addListener(_onSearchChanged);
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent-10) {
        await loadPosts();
      }
    });
  }

  Future<void> loadPosts() async {
    try {
      final snapshot = await AuthService.db.collection("posts").get();

      if (snapshot.docs.isEmpty) {
        return;
      }

      final postIds = snapshot.docs.map((post) => post['id']).cast<String>().toList();
      final shuffledIds = postIds..shuffle();
      final ids =
          shuffledIds.where((id) => !_loadedPostIds.contains(id)).take(5);

      setState(() {
        _loadedPostIds=ids.toList();
      });
    } catch (e) {
      print("Error loading posts: $e");
    }
  }

  Future<List<HomePost>> getHomePostWidgets() async {
    final widgets = <HomePost>[];

    for (final id in _loadedPostIds) {
      final doc = await AuthService.db.collection("posts").doc(id).get();
      if (doc.exists) {
        widgets.add(HomePost(postData: doc.data()!));
      }
    }

    return widgets;
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
      loadPosts();
      return;
    }

    final ref = AuthService.db.collection("posts");

    try {
      final snapshot = await ref.get();

      final postIds =
          snapshot.docs.where((postData) {
                final title = (postData['title'] ?? '').toString().toLowerCase();
                final content = (postData['description'] ?? '')
                    .toString()
                    .toLowerCase();
                return title.contains(query) || content.contains(query);
              }).map<String>((postData)=>postData.id);

      setState(() {
        _loadedPostIds=postIds.toList();
      });
    } catch (e) {
      print("Error during search: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              margin:EdgeInsets.only(top:100,bottom: 60),
              child:    Scrollbar(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: FutureBuilder(
                    future: getHomePostWidgets(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                decoration: OurUI.shapeDecoration(color:Colors.black.withAlpha(64),hasShadow: false),
                                child:Container(
                                  padding:EdgeInsets.all(10),
                                  child: OurFont(text: "No posts found..."),
                                )

                            )

                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: snapshot.data!,
                        );
                      }
                    },
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
                  loadPosts();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
