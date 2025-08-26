import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/MapService.dart';
import 'package:gan/utils/OurUI.dart';
import 'package:gan/widgets/HomePost.dart';
import 'package:gan/widgets/MyNavigationBar.dart';
import 'package:gan/widgets/OurFont.dart';
import 'package:gan/widgets/TopBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> preparedPostIDs = [];
  List<String> _loadedPostIds = [];
  List<Widget> postWidgets = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchBarController = TextEditingController();

  Timer? _debounce;

  @override
  void initState() {
    preparePosts();

    super.initState();
    searchBarController.addListener(_onSearchChanged);
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        await loadNewPosts();
      }
    });
  }

  Future<void> loadCreatedPostAtTop(String newPostID) async{
    _loadedPostIds.insert(0, newPostID);
    postWidgets.insert(0, HomePost(id: newPostID));
    setState(() {

    });
  }
  Future<void> preparePosts() async {
    final snapshot = await AuthService.db.collection("posts").get();
    preparedPostIDs = snapshot.docs
        .map((post) => post['id'])
        .cast<String>()
        .toList();
    preparedPostIDs.shuffle();
    loadNewPosts();
  }

  Future<void> loadNewPosts() async {
    try {
      if (preparedPostIDs.isEmpty) {
        return;
      }

      final ids = preparedPostIDs
          .where((id) => !_loadedPostIds.contains(id))
          .take(3);

      for (var id in ids) {
        loadPost(id);
      }
      setState(() {});
    } catch (e) {
      print("Error loading posts: $e");
    }
  }

  void loadPost(String postID){
    _loadedPostIds.add(postID);
    postWidgets.add(HomePost(id: postID));
  }

  void emptyPosts(){
    _loadedPostIds.clear();
    postWidgets.clear();
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
      loadNewPosts();
      return;
    }

    print("searching for post: $query");
    final ref = AuthService.db.collection("posts");

    try {
      final snapshot = await ref.get();

      final postIds = snapshot.docs
          .where((postData) {

            final title = (postData['title'] ?? '').toString().toLowerCase();
            final dsecription = (postData['description'] ?? '')
                .toString()
                .toLowerCase();
            final location=(MapService.getAddressFromCoordinates(postData['locationCoordinates'])??'').toString().toLowerCase();
            return title.contains(query) || dsecription.contains(query) || location.contains(query);
          })
          .map<String>((postData) => postData.id);

      emptyPosts();
      for(var id in postIds){
        loadPost(id);
      }
      setState(() {

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
              margin: EdgeInsets.only(top: 100, bottom: 60),
              height:MediaQuery.sizeOf(context).height,
              child: Scrollbar(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: postWidgets,
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
                final newPostID = await Navigator.pushNamed(
                  context,
                  "/CreatePost",
                );
                if (newPostID!="") {
                  loadCreatedPostAtTop(newPostID as String);
                }

              },
            ),
          ],
        ),
      ),
    );
  }
}
