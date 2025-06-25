import 'package:flutter/material.dart';
import 'package:gan/pages/GroupChat.dart';
import 'package:gan/pages/Home.dart';
import 'package:gan/pages/Scan.dart';
import 'package:gan/pages/UserProfile.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:gan/widgets/NavigationButton.dart';

class MyNavigationBar extends StatelessWidget {

  const MyNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery
            .sizeOf(context)
            .width,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFE0FBFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavigationButton(
              label: 'Home',
              icon: Icons.home,
              onTap: () {
                NavigatorService.openPage(Home(), context, false);
              },
            ),
            NavigationButton(
              label: 'Chats',
              icon: Icons.chat,
              onTap: () {
                NavigatorService.openPage(GroupChat(), context, false);
              },
            ),
            NavigationButton(
              label: 'Profile',
              icon: Icons.account_circle,
              onTap: () {
                NavigatorService.openPage(UserProfile(viewingUID: AuthService.uid), context, true);
              },
            ),
            NavigationButton(
              label: 'Scan',
              icon: Icons.camera_alt,
              onTap: () {
                NavigatorService.openPage(Scan(), context, false);
              },
            ),
          ],
        ),
      ),
    );
  }
}


