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
              overlayImage: AssetImage("assets/images/home.png"),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                    '/Home'
                );
              },
            ),
            NavigationButton(
              label: 'Chats',
              overlayImage: AssetImage("assets/images/Chat.png"),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/GroupChat',
                ); // 跳转到 Chats 页面
              },
            ),
            NavigationButton(
              label: 'Profile',
              overlayImage: AssetImage("assets/images/Profile.png"),
              onTap: () {
                // 跳转到 Profile 页面
              },
            ),
            NavigationButton(
              label: 'Scan',
              overlayImage: AssetImage("assets/images/Scan.png"),
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


