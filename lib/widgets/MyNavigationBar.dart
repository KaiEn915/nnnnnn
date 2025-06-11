import 'package:flutter/material.dart';
import 'package:gan/pages/GroupChat.dart';
import 'package:gan/pages/Home.dart';
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
                Navigator.pushReplacementNamed(
                  context,
                    '/Home'
                );
              },
            ),
            NavigationButton(
              label: 'Chats',
              icon: Icons.chat,
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/GroupChat',
                ); // 跳转到 Chats 页面
              },
            ),
            NavigationButton(
              label: 'Profile',
              icon: Icons.account_circle,
              onTap: () {
                // 跳转到 Profile 页面
              },
            ),
            NavigationButton(
              label: 'Scan',
              icon: Icons.camera_alt,
              onTap: () {
                // 跳转到 Scan 页面
              },
            ),
          ],
        ),
      ),
    );
  }
}


