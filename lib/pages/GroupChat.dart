import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
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
                bottom: 75,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(border: Border.all(width: 0)),
                  child: SingleChildScrollView(
                    child: Scrollbar(
                      child: FutureBuilder<List<DocumentSnapshot>>(
                        future: () async {
                          final snapshot = await AuthService.userDocRef.get();
                          final groupChatIds = snapshot.data()?['groupChats'] as List<dynamic>? ?? [];

                          return Future.wait(
                            groupChatIds.map((id) {
                              return AuthService.db.collection("groupChats").doc(id).get();
                            }),
                          );
                        }(),
                        builder: (context, groupSnapshot) {
                          if (groupSnapshot.hasError) return Text("Error loading group chats");
                          if (!groupSnapshot.hasData){
                            return Center(child: CircularProgressIndicator());
                          }


                          final groupChatDocs = groupSnapshot.data!;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: groupChatDocs.map((doc) {

                              return doc.exists? Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: GroupChatPost(
                                  data: doc.data() as Map<String, dynamic>,
                                ),
                              ):SizedBox();
                            }).toList(),
                          );
                        },
                      )

                    ),
                  ),
                ),
              ),

              TopBar(isMiddleSearchBar: false, header: "GROUP CHATS"),
            ],
          ),
        ),

    );
  }
}
