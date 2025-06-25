import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/RecognitionService.dart';
import 'package:gan/utils/OurUI.dart';
import 'package:gan/widgets/OurFont.dart';
import 'package:gan/widgets/SimilarPetPost.dart';
import 'package:gan/widgets/TopBar.dart';
import 'package:tflite_v2/tflite_v2.dart';

class PetImageAnalysis extends StatefulWidget {
  const PetImageAnalysis({super.key, required this.image});

  final XFile image;

  @override
  State<StatefulWidget> createState() => _PetImageAnalysisState();
}

class _PetImageAnalysisState extends State<PetImageAnalysis> {
  List<dynamic>? _recognitions;
  String breed="Unknown";
  List<SimilarPetPost> _postWidgets=[];

  @override
  void initState() {
    super.initState();

    initRecognition();

  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initRecognition() async{
    _recognitions=await RecognitionService.recognizeImage(widget.image.path);
    breed=_recognitions?[0]['label'];

    try {
      final snapshot = await AuthService.db.collection("posts").where('breed', isEqualTo: breed).get();

      if (snapshot.docs.isEmpty) {
        Fluttertoast.showToast(msg: "No similar missing pet posts...");
        return;
      }

      final posts = snapshot.docs.map((doc) => doc.data()).take(5).toList();

      setState(() {
        breed=breed;
        _postWidgets.addAll(posts.map((p) => SimilarPetPost(postData: p)));
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
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
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 100),
              width: 332,
              height: 750,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white.withAlpha(64)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  Container(
                    height: 125,
                    decoration: ShapeDecoration(
                      color: const Color(0xBFEAF9F6),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.25),
                        borderRadius: BorderRadius.circular(25),
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
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            bottom: -30,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/Cat3.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ClipOval(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: FileImage(File(widget.image.path)),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            width: 140,
                            right: 0,
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  child: OurFont(text: "POSSIBLE BREED"),
                                ),
                                Container(
                                  height: 55,
                                  child: OurFont(
                                    text: breed,
                                    filledColor: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: ShapeDecoration(
                      color: const Color(0x7FFFFEF3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: ShapeDecoration(
                            color: const Color(0x80F9F9F4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x20000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Container(
                                width: 32,
                                child: Icon(Icons.pin_drop, color: Colors.red),
                              ),
                              SizedBox(
                                width: 192,
                                height: 72,
                                child: OurFont(text: "SIMILAR PETS"),
                              ),
                              Container(
                                width: 32,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/cat4.png"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Scrollbar(
                          child: SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              height: 500,
                              clipBehavior: Clip.none,
                              decoration: ShapeDecoration(
                                color: Colors.white.withAlpha(128),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Column(
                                children: _postWidgets
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
          ),
          TopBar(
            isMiddleSearchBar: false,
            header: "卧槽",
            leftIcon: Icons.arrow_back,
            leftIcon_onTap: () => {Navigator.pop(context)},
          ),
        ],
      ),
    );
  }
}
