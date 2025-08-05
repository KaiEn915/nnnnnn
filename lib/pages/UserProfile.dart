import 'package:flutter/material.dart';
import 'package:gan/pages/FavoritePost.dart';
import 'package:gan/pages/Setting.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/ImageService.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:gan/utils/OurUI.dart';
import 'package:gan/widgets/MyNavigationBar.dart';
import 'package:gan/widgets/TopBar.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key, required this.viewingUID});

  final String viewingUID;

  bool get isViewingOther => viewingUID != AuthService.uid;

  @override
  State<UserProfile> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
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
            FutureBuilder(
              future: AuthService.db
                  .collection('users')
                  .doc(widget.viewingUID)
                  .get(),
              builder: (context, snapshot) {

                if (!snapshot.hasData) return Center(child:CircularProgressIndicator());
                final userData=snapshot.data!.data();

                return Positioned(
                  left: 0,
                  right: 0,
                  top: 110,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 450,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    clipBehavior: Clip.antiAlias,
                    decoration: OurUI.shapeDecoration(
                      color: Colors.white.withAlpha(32),
                      hasShadow: false,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 40,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white.withAlpha(100),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 117,
                                  height: 117,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: ImageService.tryDisplayImage(
                                    userData?['imageData']??"",
                                    117,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 270,
                            height: 67,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/Cloud.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 5,
                              ),
                              child: Text(
                                userData?['username'] ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 32,
                                  fontFamily: 'Iceland',
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                  letterSpacing: -0.32,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              userData?['bio'] ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 1.50,
                                letterSpacing: -0.15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            MyNavigationBar(),
            widget.viewingUID.isEmpty
                ? Center(child: CircularProgressIndicator())
                : widget.isViewingOther
                ? SizedBox()
                : Positioned(
                    left: 0,
                    right:0,
                    bottom: 100,
                    child: Container(
                      height: 150,
                      decoration: ShapeDecoration(
                        color: const Color(0xBFECFFFA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 10,
                            top: 17,
                            child: Container(
                              width: 350,
                              height: 115,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/PutButton.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 80,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/Voucher',
                                            );
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  "assets/images/ticket.png",
                                                ),
                                                fit: BoxFit.contain,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xBFFFFFFF),
                                                  blurRadius: 4,
                                                  offset: Offset(0, 4),
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            NavigatorService.openPage(
                                              FavoritePost(),
                                              false,
                                            );
                                          },
                                          child: Icon(Icons.bookmark, size: 40),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            widget.viewingUID.isEmpty
                ? Center(child: CircularProgressIndicator())
                : widget.isViewingOther
                ? SizedBox()
                : Positioned(
                    left: 175,
                    top: 574,
                    child: Container(
                      width: 58,
                      height: 44,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/cat2.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
            TopBar(
              isMiddleSearchBar: false,
              leftIcon: Icons.arrow_back,
              leftIcon_onTap: () {
                Navigator.pop(context);
              },
              header: "PROFILE",
              rightIcon: widget.isViewingOther ? null : Icons.settings_outlined,
              rightIcon_onTap: (){
                NavigatorService.openPage(Setting(), false);
              }
            ),
          ],
        ),
      ),
    );
  }
}
