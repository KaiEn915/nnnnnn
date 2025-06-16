import 'package:flutter/material.dart';
import 'package:gan/widgets/GroupChatPost.dart';
import 'package:gan/widgets/MyNavigationBar.dart';
import 'package:gan/widgets/TopBar.dart';

class GroupChat extends StatelessWidget {
  const GroupChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                top: 96,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 530,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(border: Border.all(width: 0)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 15,
                    children: [
                      GroupChatPost(),
                      GroupChatPost(),
                    ],
                  ),
                ),
              ),
              TopBar(isMiddleSearchBar: false,header: "GROUP CHATS")
            ],
          ),
        ),
      ],
    );
  }
}