import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gan/pages/Home.dart';
import 'package:gan/pages/UserProfile.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/GroupChatService.dart';
import 'package:gan/services/ImageService.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:gan/utils/OurUI.dart';
import 'package:gan/widgets/AppButton.dart';
import 'package:gan/widgets/OurFont.dart';
import 'package:gan/widgets/PostAttribute.dart';
import 'package:gan/widgets/TopBar.dart';

class GroupChatDetail extends StatefulWidget {
  const GroupChatDetail({super.key, required this.groupChatId});

  final String groupChatId;

  @override
  State<GroupChatDetail> createState() => _GroupChatDetailWidgetState();
}

class _GroupChatDetailWidgetState extends State<GroupChatDetail> {
  DocumentReference<Map<String, dynamic>>? dbRef;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: AuthService.db
            .collection("groupChats")
            .doc(widget.groupChatId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data?.data() == null) {
            return Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data?.data();
          final membersUid = data?['members_uid'] as List<dynamic>;

          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background3.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    spacing: 25,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          width: 150,
                          height: 150,
                          color: Colors.white.withAlpha(128),
                          child: ImageService.tryDisplayImage(
                            data?['imageData'] ?? "",
                            150,
                          ),
                        ),
                      ),
                      Container(child: OurFont(text: data?['title'] ?? '')),
                      Container(
                        height: 100,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE5E5CF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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
                            PostAttribute.description(
                              data?['description'] ?? '',
                              height: 40,
                            ),
                            PostAttribute.since(
                              data?['timestamp'] ?? 0,
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 250,
                        clipBehavior: Clip.antiAlias,
                        padding: EdgeInsets.all(10),
                        decoration: OurUI.shapeDecoration(
                          color: Color(0xFFD5EDF8),
                        ),
                        child: Column(
                          spacing: 10,
                          children: [
                            OurFont(text: "MEMBERS"),
                            Container(
                              width: 300,
                              height: 175,
                              child: FutureBuilder<List<Map<String, dynamic>>>(
                                future: Future.wait(
                                  membersUid.map((uid) async {
                                    final doc = await AuthService.db
                                        .collection('users')
                                        .doc(uid)
                                        .get();
                                    return doc.exists && doc.data() != null
                                        ? doc.data()!
                                        : {};
                                  }),
                                ),
                                builder: (context, membersData) {
                                  if (!membersData.hasData)
                                    return CircularProgressIndicator();
                                  return Scrollbar(
                                    child: SingleChildScrollView(
                                      child: Wrap(
                                        spacing: 14,
                                        runSpacing: 10,
                                        alignment: WrapAlignment.center,
                                        children: membersData.data!.map((user) {
                                          final name =
                                              user["username"] ?? "Unknown";
                                          Widget imageWidget =
                                              ImageService.tryDisplayImage(
                                                user['imageData'] ?? "",
                                                40,
                                              );
                                          Timestamp lastUpdated =
                                              user['lastUpdated'];
                                          final isOnline =
                                              DateTime.now()
                                                  .difference(
                                                    lastUpdated.toDate(),
                                                  )
                                                  .inMinutes <=
                                              10;

                                          return GestureDetector(
                                            onTap: () {
                                              NavigatorService.openPage(
                                                UserProfile(
                                                  viewingUID: user['uid'],
                                                ),
                                                context,
                                                false,
                                              );
                                            },
                                            child: Container(
                                              width: 140,
                                              height: 60,
                                              clipBehavior: Clip.antiAlias,
                                              decoration:
                                                  OurUI.shapeDecoration(),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 5,
                                              ),
                                              child: Row(
                                                spacing: 5,
                                                children: [
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        side: BorderSide(
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                100,
                                                              ),
                                                          child: FittedBox(
                                                            child: imageWidget,
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 0,
                                                          right: 0,
                                                          child: Container(
                                                            width: 12,
                                                            height: 12,
                                                            decoration: BoxDecoration(
                                                              color: isOnline
                                                                  ? Colors.green
                                                                  : Colors.red,
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.4,
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      AuthService.uid == data?['owner_uid']
                          ? AppButton(
                              text: "Delete Group Chat",
                              backgroundColor: const Color(0xFF740000),
                              onPressed: () {
                                GroupChatService.deleteGroupChat(
                                  widget.groupChatId,
                                );
                                NavigatorService.openPage(
                                  Home(),
                                  context,
                                  true,
                                );
                              },
                            )
                          : AppButton(
                              text: "Quit Group Chat",
                              backgroundColor: const Color(0xFF740000),
                              onPressed: () {
                                GroupChatService.quitGroupChat(
                                  widget.groupChatId,
                                );
                                NavigatorService.openPage(
                                  Home(),
                                  context,
                                  true,
                                );
                              },
                            ),
                    ],
                  ),
                ),
                TopBar(
                  isMiddleSearchBar: false,
                  header: "ABOUT",
                  leftIcon: Icons.arrow_back,
                  leftIcon_onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
