import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/widgets/MyNavigationBar.dart';
import 'package:gan/widgets/TopBar.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key,required this.viewingUID});
  final String viewingUID;
  bool get isViewingOther => viewingUID != AuthService.uid;


  @override
  State<UserProfile> createState() => _UserProfileWidgetState();

}
  class _UserProfileWidgetState extends State<UserProfile> {
  Map<String,dynamic>? viewingUserData;

  @override void initState() {
    super.initState();
   initViewingUserData();
  }

  Future<void> initViewingUserData() async{
    final data=await AuthService.getUserData(widget.viewingUID);
    setState(() {
      viewingUserData = data;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: viewingUserData==null? const Center(child:CircularProgressIndicator()):Column(
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
                Positioned(
                  left: 0,
                  right:0,
                  top: 110,
                  // 过后再改
                  child: Container(
                    width: 370,
                    height: 450,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white.withAlpha(5),
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
                                child: viewingUserData?['imageData']!=null?
                                Image.memory(base64Decode(viewingUserData?['imageData']),width: 117,height: 117):Icon(Icons.verified),
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
                              viewingUserData?['username']??"",
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
                            viewingUserData?['bio']??"",
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
                MyNavigationBar(),
                widget.isViewingOther? SizedBox(): Positioned(
                  left: 21,
                  top: 600,
                  child: Container(
                    width: 370,
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
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/PutButton.png"),
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
                                      Container(
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
                                      Container(
                                        width: 40,
                                        height: 40,
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
                widget.isViewingOther? SizedBox():Positioned(
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
                  leftIcon: widget.isViewingOther? Icons.arrow_back:null,
                  leftIcon_onTap: widget.isViewingOther? (){Navigator.pop(context);}:null,
                  header: "PROFILE",
                  rightIcon: widget.isViewingOther? null: Icons.settings_outlined,
                  rightIcon_onTap: () async {
                    final result =await Navigator.pushNamed(context, "/Setting");

                    if (result == 'updated') {
                      initViewingUserData();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      )
    );

  }
}
