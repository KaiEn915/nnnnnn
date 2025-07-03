import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/ImageService.dart';
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
  Map<String, dynamic>? groupChatData = {};
  bool get isGroupChatOwner =>AuthService.uid==groupChatData?['owner_uid'];


  @override
  void initState() {
    super.initState();
    loadGroupChatData();
  }

  Future<void> loadGroupChatData() async {
    dbRef = AuthService.db.collection("groupChats").doc(widget.groupChatId);
    final docSnap = await dbRef?.get();

    setState(() {
      groupChatData = docSnap?.data();
    });
  }
  Future<List<Map<String, dynamic>>> _loadUserData(List<dynamic> uids) async {
    final futures = uids.map((uid) async {
      final doc = await AuthService.db.collection("users").doc(uid).get();
      return (doc.data() ?? {}) as Map<String, dynamic>;
    });

    return await Future.wait(futures);
  }
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
                    Container(
                      width: 150,
                      height: 150,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: ImageService.tryDisplayImage(
                          groupChatData?['imageData'],
                        ),
                      ),
                    ),
                    Container(child: OurFont(text: groupChatData?['title'] ?? '')),
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
                        children: [
                          PostAttribute.description(
                            groupChatData?['description'] ?? '',
                            height: 40,
                          ),
                          PostAttribute.since(
                            groupChatData?['timestamp'] ?? 0,
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
                            child: FutureBuilder<DocumentSnapshot>(
                              future: AuthService.db.collection("groupChats").doc(widget.groupChatId).get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) return Text("Error loading group");
                                if (!snapshot.hasData || !snapshot.data!.exists) return CircularProgressIndicator();

                                final data = snapshot.data!.data() as Map<String, dynamic>;
                                final List<dynamic> memberUids = data["members_uid"] ?? [];

                                return FutureBuilder<List<Map<String, dynamic>>>(
                                  future: _loadUserData(memberUids),
                                  builder: (context, userSnap) {
                                    if (userSnap.connectionState == ConnectionState.waiting) return CircularProgressIndicator();
                                    if (userSnap.hasError) return Text("Error loading user data");

                                    final users = userSnap.data ?? [];

                                    return Scrollbar(
                                      child: SingleChildScrollView(
                                        child: Wrap(
                                          spacing: 14,
                                          runSpacing: 10,
                                          alignment: WrapAlignment.center,
                                          children: users.map((user) {
                                            final name = user["username"] ?? "Unknown";
                                            Widget imageWidget=ImageService.tryDisplayImage(user['imageData']);
                                            final isOnline = user["isOnline"] ?? false;

                                            return Container(
                                              width: 140,
                                              height: 60,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: OurUI.shapeDecoration(),
                                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                              child: Row(
                                                spacing: 5,
                                                children: [
                                                  Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: ShapeDecoration(
                                                        shape: RoundedRectangleBorder(
                                                          side: BorderSide(width: 1),
                                                          borderRadius: BorderRadius.circular(100),
                                                        ),
                                                      ),
                                                      child:Stack(
                                                        children: [
                                                          ClipRRect(
                                                              borderRadius: BorderRadius.circular(100),
                                                              child: FittedBox(
                                                                child:imageWidget
                                                              )
                                                          ),
                                                          Positioned(
                                                            bottom:0,
                                                            right:0,
                                                            child: Container(
                                                              width: 12,
                                                              height: 12,
                                                              decoration: BoxDecoration(
                                                                color: isOnline ? Colors.green : Colors.red,
                                                                shape: BoxShape.circle,
                                                                border: Border.all(color: Colors.white, width: 1),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                  ),
                                                  Text(
                                                    name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.4,
                                                      decoration: TextDecoration.none
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    isGroupChatOwner?
                    AppButton(
                      text: "Delete Group Chat",
                      backgroundColor: const Color(0xFF740000),
                      onPressed: () {
                        AuthService.deleteGroupChat(context,widget.groupChatId);
                      },
                    ):    AppButton(
                      text: "Quit Group Chat",
                      backgroundColor: const Color(0xFF740000),
                      onPressed: () {
                        AuthService.quitGroupChat(context,widget.groupChatId);
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
        ),
      ],
    );
  }
}