import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/ImageService.dart';
import 'package:gan/services/MapService.dart';
import 'package:gan/services/PostService.dart';
import 'package:gan/utils/OurUI.dart';
import 'package:gan/widgets/AppButton.dart';
import 'package:gan/widgets/LabeledInputBox.dart';
import 'package:gan/widgets/TopBar.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<StatefulWidget> createState() => _CreatePost();
}

class _CreatePost extends State<CreatePost> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  Uint8List currentImageData = Uint8List(0);
  var breed = "Unknown Breed";

  @override
  void initState() {
    super.initState();
    initializePost();
  }

  void initializePost() async {
    final snapshot = await AuthService.userDocRef.get();
    final data = snapshot.data();
    String address = await MapService.getAddressFromCoordinates(
      data?['locationCoordinates'],
    );

    setState(() {
      locationController.text = address;
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
            TopBar(
              isMiddleSearchBar: false,
              header: "CREATE POST",
              leftIcon: Icons.arrow_back,
              leftIcon_onTap: () => {Navigator.pop(context)},
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 700,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 120),
              clipBehavior: Clip.none,
              decoration: ShapeDecoration(
                color: Colors.white.withAlpha(128),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: OurUI.shapeDecoration(),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Center(
                              child: Container(
                                margin:EdgeInsets.all(10),
                                child: FittedBox(
                                  child: ImageService.tryDisplayImage(
                                    base64Encode(currentImageData),200
                                  ),
                                ),
                              ),
                            ),
                            Positioned(

                              bottom: -15,
                              right: -15,
                              child: GestureDetector(
                                onTap: () async {
                                  XFile? image =
                                      await ImageService.promptPicture(
                                        true,
                                      );
                                  final bytes = await image.readAsBytes();
                                  setState(() {
                                    currentImageData = bytes;
                                  });
                                },
                                child: Icon(
                                  Icons.upload,
                                  size: 32,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      LabeledInputBox(
                        isInputLocation: false,
                        label: "Title: ",
                        placeholder: "Enter your post title...",
                        width: 300,
                        textController: titleController,
                      ),
                      LabeledInputBox(
                        isInputLocation: true,
                        label: "Location: ",
                        placeholder: "Select missing location",
                        width: 250,
                        textController: locationController,
                      ),
                      LabeledInputBox(
                        isInputLocation: false,
                        label: "Description: ",
                        placeholder: "Enter your post description",
                        width: 300,
                        height: 170,
                        textController: descriptionController,
                      ),
                      AppButton(
                        text: "Post",
                        width: 150,
                        onPressed: () async {
                          await PostService.createPost(
                            title: titleController.text,
                            imageData: currentImageData,
                            description: descriptionController.text,
                            breed: breed,
                            uid: AuthService.uid,
                            locationCoordinates:
                                await MapService.getCoordinatesFromAddress(
                                  locationController.text,
                                ),
                          );

                          Navigator.pop(context, "postCreated");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
