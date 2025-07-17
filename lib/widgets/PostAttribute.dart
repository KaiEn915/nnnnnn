import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/UserProfile.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/MapService.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostAttribute extends StatelessWidget {
  final String title;
  final Icon? icon;
  final VoidCallback? onTap;
  final double height;

  const PostAttribute({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
    this.height = 20,
  });

  /// Location address from GeoPoint
  static Future<Widget> address(
      BuildContext context,
      GeoPoint locationCoordinates, {
        double height = 40.0,
      }) async {
    final address = await MapService.getAddressFromCoordinates(locationCoordinates);
    return PostAttribute(
      title: address,
      icon: Icon(Icons.pin_drop, color: Colors.red, size: 20),
      onTap: () => MapService.openMap(context, locationCoordinates),
      height: height,
    );
  }

  /// Post owner display
  static Widget postOwner(BuildContext context, String username, String uid,
      {double height = 20}) {
    return PostAttribute(
      title: "Posted by $username",
      icon: Icon(Icons.account_circle, size: 20),
      onTap: () {
        NavigatorService.openPage(UserProfile(viewingUID: uid), context, false);

      },
      height: height,
    );
  }

  /// Time since post
  static Widget since(int timestamp, {double height = 20}) {
    return PostAttribute(
      title: "Since ${timeago.format(DateTime.fromMillisecondsSinceEpoch(timestamp))}",
      icon: Icon(Icons.history, size: 20),
      height: height,
    );
  }

  /// Phone number
  static Widget phoneNumber(String phone, {double height = 20}) {
    return PostAttribute(
      title: phone,
      icon: Icon(Icons.phone, size: 20),
      height: height,
    );
  }

  /// Email
  static Widget email(String email, {double height = 20}) {
    return PostAttribute(
      title: email,
      icon: Icon(Icons.email, size: 20),
      height: height,
    );
  }

  /// Post title
  static Widget postTitle(String title, {double height = 20}) {
    return PostAttribute(
      title: title,
      icon: Icon(Icons.title, size: 20),
      height: height,
    );
  }

  /// Description
  static Widget description(String description, {double height = 20}) {
    return PostAttribute(
      title: "About my pet: $description",
      icon: Icon(Icons.info, size: 20),
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: ShapeDecoration(
        color: Colors.white.withAlpha(128),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          spacing: 5,
          children: [
            if (icon != null) icon!,
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
