import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gan/pages/GroupChat.dart';
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
  final TextEditingController searchBarController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    searchBarController.addListener(_onSearchChanged);
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
                  MyNavigationBar(),

                  Positioned(
                    //里面的边框
                    left: 0,
                    top: 96,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 760,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20,
                        children: [
                          //post里面的东西
                          HomePost(),
                          HomePost(),
                        ],
                      ),
                    ),
                  ),
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
                            Container(
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
