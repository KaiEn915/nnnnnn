import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/UserProfile.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/MapService.dart';
import 'package:timeago/timeago.dart' as timeago;
class PostAttribute extends StatelessWidget {
  final String title;
  final Icon? icon;
  final VoidCallback? onTap;

  const PostAttribute({super.key, required this.title, this.icon, this.onTap});

  static Future<Widget> address(
    BuildContext context,
    GeoPoint locationCoordinates,
  ) async {
    final address = await MapService.getAddressFromCoordinates(
      locationCoordinates,
    );
    return PostAttribute(
      title: address,
      icon: Icon(Icons.pin_drop, color: Colors.red, size: 20),
      onTap: () {
        MapService.openMap(context, locationCoordinates);
      },
    );
  }

  static Widget postOwner(BuildContext context, String username, String uid) {
    return PostAttribute(
      title: "Posted by $username",
      icon: Icon(Icons.account_circle, size: 20),
      onTap: () {
        if (uid != AuthService.uid) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfile(viewingUID: uid),
            ),
          );
          Fluttertoast.showToast(msg: "Viewing user: $username");
        } else {
          Fluttertoast.showToast(msg: "You are the post user...");
        }
      },
    );
  }

  static Widget since(int timestamp) {
    return PostAttribute(
      title:
          "Since ${timeago.format(DateTime.fromMillisecondsSinceEpoch(timestamp))}",
      icon: Icon(Icons.history, size: 20),
    );
  }
  static Widget phoneNumber(String phoneNumber) {
    return PostAttribute(
      title:
      phoneNumber,
      icon: Icon(Icons.phone, size: 20),
    );
  }
  static Widget email(String email) {
    return PostAttribute(
      title:
      email,
      icon: Icon(Icons.email, size: 20),
    );
  }
  static Widget postTitle(String title) {
    return PostAttribute(
      title:
      title,
      icon: Icon(Icons.email, size: 20),
    );
  }
  static Widget description(String description) {
    return PostAttribute(
      title:
      "About my pet: $description",
      icon: Icon(Icons.info, size: 20),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white.withAlpha(128),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          spacing: 5,
          children: [
            Container(child: icon),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
