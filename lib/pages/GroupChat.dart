import 'package:flutter/material.dart';
import 'package:gan/pages/GroupChatRoom.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/widgets/GroupChatPost.dart';
import 'package:gan/widgets/MyNavigationBar.dart';
import 'package:gan/widgets/TopBar.dart';

class GroupChat extends StatefulWidget {
  const GroupChat({super.key});

  @override
  State<StatefulWidget> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  List<GroupChatPost> _postWidgets = [];

  @override
  void initState() {
    super.initState();
    loadGroupChats();
  }

  Future<void> loadGroupChats() async {
    AuthService.updateUserData();
    final ref = AuthService.db.collection("groupChats");

    // Get list of groupChat document IDs from the user's data
    List<dynamic> userGroupsId = AuthService.userData?['groupChats'] ?? [];
    List<GroupChatPost> groupChatsData = [];

    for (String id in userGroupsId) {
      final docSnap = await ref.doc(id).get();
      if (docSnap.exists) {
        groupChatsData.add(GroupChatPost(data:docSnap.data()!)); // `!` because we already checked exists
      }
    }

    setState(() {
      _postWidgets=groupChatsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery
              .sizeOf(context)
              .width,
          height: MediaQuery
              .sizeOf(context)
              .height,
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
                  width: MediaQuery
                      .sizeOf(context)
                      .width,
                  height: 530,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(border: Border.all(width: 0)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 15,
                    children: _postWidgets,
                  ),
                ),
              ),
              TopBar(isMiddleSearchBar: false, header: "GROUP CHATS")
            ],
          ),
        ),
      ],
    );
  }
}