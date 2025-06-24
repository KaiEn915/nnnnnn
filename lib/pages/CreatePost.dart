import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/ImageService.dart';
import 'package:gan/services/MapService.dart';
import 'package:gan/services/RecognitionService.dart';
import 'package:gan/utils/OurUI.dart';
import 'package:gan/widgets/AppButton.dart';
import 'package:gan/widgets/LabeledInputBox.dart';
import 'package:gan/widgets/TopBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

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
    await AuthService.updateUserData();

    String address = await MapService.getAddressFromCoordinates(
      AuthService.userData?['locationCoordinates'],
    );

    setState(() {
      locationController.text = address;
    });
  }

  Future<void> createPost({
    required BuildContext context,
    required String title,
    required String description,
    required String uid,
    required String breed,
    required GeoPoint? locationCoordinates,
  }) async {



    final postData = {
      "title": title,
      "description": description,
      "ownerUid": uid,
      "username": AuthService.userData?['username'],
      "phoneNumber": AuthService.userData?['phoneNumber'],
      "email": AuthService.userData?['email'],
      "imageData": base64Encode(currentImageData),
      "locationCoordinates": locationCoordinates,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "breed": breed,
    };
    final postRef = await AuthService.db.collection("posts").add(postData);
    await postRef.update({"id": postRef.id});

    String groupChatId="";
    if (await doCreateGroupChat(context)) {
      groupChatId = await AuthService.createGroupChat(
        context,
        postRef.id,
        "$title's Group Chat",
        description,
      );

    }
    await postRef.update({
      "groupChatId": groupChatId,
    });


  }

  static Future<bool> doCreateGroupChat(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Group Chat"),
          content: Text("Do you want to create a group chat for this post?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );

    return result == true;
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
            Center(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 700,
                  margin: EdgeInsets.only(left: 15, right: 15, top: 0),
                  decoration: ShapeDecoration(
                    color: Colors.white.withAlpha(128),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 250,
                        width: 250,
                        decoration: OurUI.shapeDecoration(),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: FittedBox(
                                child: ImageService.tryDisplayImage(
                                  base64Encode(currentImageData),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () async {
                                  XFile? image = await ImageService.pickImage(ImageSource.gallery);
                                  if (image == null) return;
                                  final bytes = await image.readAsBytes();
                                  setState(() {
                                    currentImageData = bytes;
                                  });
                                },
                                child: Icon(Icons.upload, size: 32, color: Colors.black),
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
                          await createPost(
                            context: context,
                            title: titleController.text,
                            description: descriptionController.text,
                            breed: breed,
                            uid: AuthService.uid,
                            locationCoordinates:
                                await MapService.getCoordinatesFromAddress(
                                  locationController.text,
                                ),
                          );

                          Navigator.pop(
                            context,
                            "postCreated",
                          );
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
