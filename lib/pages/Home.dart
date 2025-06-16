import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gan/pages/GroupChat.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/HomePostManager.dart';
import 'package:gan/widgets/HomePost.dart';
import 'package:gan/widgets/MyNavigationBar.dart';
import 'package:gan/widgets/NavigationButton.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final ref = AuthService.dbRef.child("posts");
    final snapshot = await ref.get();

    if (!snapshot.exists) {
      print("No posts found");
      return;
    }

    final postMap = Map<String, dynamic>.from(snapshot.value as Map);
    final postList = postMap.entries.map((e) {
      return Map<String, dynamic>.from(e.value);
    }).toList();

    // Shuffle the list
    postList.shuffle(Random());

    // Choose 5 random posts (or however many you want)
    final randomPosts = postList.take(5).toList();

    setState(() {
      _postWidgets.addAll(randomPosts.map((p) => HomePost(postData: p)));
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      search();
    });
  }

  void search() {
    String query = searchBarController.text.trim();
    if (query.isNotEmpty) {
      print("Searching for: $query");
      // You can add your search logic here
    } else {
      print("Search bar is empty.");
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    child: Container(
                      //search box table
                      width: MediaQuery.sizeOf(context).width,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      // margin: const EdgeInsets.symmetric(horizontal: 15),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.white.withAlpha(192),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 0),
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          spacing: 10,
                          children: [
                            Container(
                              width: 244,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 9,
                              ),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white.withAlpha(192),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 180,
                                    height: 31,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: const Color(0xFFDFDFDF),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: searchBarController,
                                      decoration: InputDecoration(
                                        hintText: 'Search post...',
                                      ),

                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        decoration: TextDecoration.none,
                                        color: const Color(0xFF828282),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 31,
                                    width: 31,
                                    child: Icon(Icons.search),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                print('yo');
                                User? user = FirebaseAuth.instance.currentUser;
                                if (user!=null){
                                  print("creatingpost");
                                  HomePostManager.createPost(
                                    description: "test",
                                    userId: user.uid,
                                    username: AuthService.userData['username'],
                                    imageUrl: "",
                                    location: "Sutera Mall",
                                  );
                                }

                              },
                              child: Container(
                                width: 37,
                                height: 37,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.white.withAlpha(192),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Icon(Icons.post_add),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
