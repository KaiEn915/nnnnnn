import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gan/pages/GroupChatRoom.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/ImageService.dart';
import 'package:gan/services/NavigatorService.dart';

class GroupChatPost extends StatelessWidget {
  const GroupChatPost({super.key, required this.data});

  int getMemberCount() {
    final members = data['members_uid'] as List<dynamic>? ?? [];
    return members.length;
  }

  Future<bool> isOtherOnline() async {
    final members = data['members_uid'] as List<dynamic>? ?? [];
    members.remove(AuthService.uid);

    for (final member in members) {
      bool isOnline=await AuthService.isOnline(member);
      if (isOnline) {
        return true;
      }
    }

    return false;
  }


  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 370,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
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
      child: GestureDetector(
        onTap: () {
          NavigatorService.openPage(
            GroupChatRoom(id: data['id']),
            context,
            false,
          );
        },
        child: Container(
          width: 370,
          height: 120,
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(0),
            image: DecorationImage(
              image: AssetImage("assets/images/GroupChatBackgroud.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(),
                    child: FittedBox(
                        child:ClipOval(
                          child: ImageService.tryDisplayImage(data['imageData']),
                        )

                    ),
                  )
              ),
              Positioned(
                left: 80,
                right: 0,
                child: Text(
                  data['title'],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left:0,
                child: Row(
                  spacing: 10,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/PokemonBall.png",
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      'Pet Status: Missing',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.account_circle),
                    Text(
                      '${getMemberCount()} / 100',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                bottom: 35,
                child: Row(
                  spacing: 10,
                  children: [
                    FutureBuilder<bool>(
                      future: isOtherOnline(),
                      builder: (context, snapshot) {
                        final online = snapshot.data ?? false;
                        return Row(
                          spacing: 10,
                          children: [
                            Icon(Icons.circle_rounded, size: 10, color: online ? Colors.green : Colors.red),
                            Text(online? "Some are online":"No others online",  style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),)
                          ],
                        );

                      },
                    )
                    ,

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
