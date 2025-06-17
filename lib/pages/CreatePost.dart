
import 'package:flutter/material.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/HomePostManager.dart';
import 'package:gan/widgets/AppButton.dart';
import 'package:gan/widgets/LabeledInputBox.dart';
import 'package:gan/widgets/TopBar.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<StatefulWidget> createState() => _CreatePost();
}

class _CreatePost extends State<CreatePost> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();


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
                    Image.asset("assets/images/cat.png", height: 300),
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
                      onPressed: ()  => {
                        HomePostManager.createPost(
                          title: titleController.text,
                          description: descriptionController.text,
                          userId: AuthService.uid,
                          username: AuthService.userData?['username'],
                          imageUrl: "",
                          location: locationController.text,
                        ),
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
