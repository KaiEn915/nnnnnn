import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/PostDetail.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/ImageService.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:gan/widgets/PostAttribute.dart';
import 'package:gan/widgets/TopBar.dart';

class FavoritePost extends StatefulWidget {
  const FavoritePost({super.key});

  @override
  State<StatefulWidget> createState() => _FavoritePostState();
}

class _FavoritePostState extends State<FavoritePost> {
  Future<void> removeFromFavoritePost(String id) async {
    await AuthService.userDocRef.update({
      "favoritePosts_id": FieldValue.arrayRemove([id]),
    });
    Fluttertoast.showToast(msg: "Post is unfavorited");

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            Positioned(
              left: 1,
              top: 100,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 700,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: FutureBuilder(
                  future: AuthService.userDocRef
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                      return const Center(
                        child: Text("No favorite posts found."),
                      );
                    }
                    final data =
                        userSnapshot.data?.data() as Map<String, dynamic>;

                    final favoriteIds = List<String>.from(
                      data["favoritePosts_id"] ?? [],
                    );

                    if (favoriteIds.isEmpty) {
                      return const Center(child: Text("No favorite posts."));
                    }

                    return FutureBuilder(
                      future: AuthService.db
                          .collection("posts")
                          .where("id", whereIn: List<String>.from(favoriteIds))
                          .get(),
                      builder: (context, postSnapshot) {
                        if (postSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (postSnapshot.hasError || !postSnapshot.hasData) {
                          return const Center(
                            child: Text("Failed to load posts."),
                          );
                        }

                        final posts = postSnapshot.data!.docs;

                        return Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          runSpacing: 15,
                          children: posts.map((doc) {
                            final postData = doc.data();

                            return GestureDetector(
                              onTap: () {
                                NavigatorService.openPage(
                                  PostDetail(postData: postData),
                                  context,
                                  false,
                                );
                              },
                              child: Container(
                                width: 180,
                                height: 270,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0x7FCDFAFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 8.5,
                                      top: 11,
                                      child: Container(
                                        width: 160,
                                        height: 244,
                                        decoration: ShapeDecoration(
                                          color: Colors.white.withAlpha(128),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          shadows: [
                                            BoxShadow(
                                              color: Color(0x3F000000),
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          spacing: 10,
                                          children: [
                                            ImageService.tryDisplayImage(
                                              postData['imageData'],
                                            ),
                                            FutureBuilder<Widget>(
                                              future: PostAttribute.address(
                                                context,
                                                postData['locationCoordinates'],
                                              ),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const SizedBox(
                                                    height: 20,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                          ),
                                                    ),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return const Text(
                                                    "Error loading address",
                                                  );
                                                } else if (!snapshot.hasData) {
                                                  return const Text(
                                                    "No address found",
                                                  );
                                                } else {
                                                  return snapshot.data!;
                                                }
                                              },
                                            ),
                                            PostAttribute.postOwner(
                                              context,
                                              postData['username'],
                                              postData['ownerUid'],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 140,
                                      top: 225,
                                      child: GestureDetector(
                                        onTap: () {
                                          removeFromFavoritePost(
                                            postData['id'],
                                          );
                                        },
                                        child: Icon(Icons.delete, size: 25),
                                      ),
                                    ),
                                    Positioned(
                                      left: 71,
                                      top: 0,
                                      child: Container(
                                        width: 30,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "assets/images/love.png",
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            TopBar(
              isMiddleSearchBar: false,
              header: "FAVORITE POSTS",
              leftIcon: Icons.arrow_back,
              leftIcon_onTap: () => {
                Navigator.pushNamed(context, "/UserProfile"),
              },
            ),
          ],
        ),
      ),
    );
  }
}
