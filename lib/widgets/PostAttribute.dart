import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gan/pages/UserProfile.dart';
import 'package:gan/services/MapService.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostAttribute extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final Color? iconColor;
  final VoidCallback? onTap;
  final double height;

  const PostAttribute({
    super.key,
    required this.title,
    this.iconData,
    this.iconColor=Colors.black,
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
      iconData: Icons.pin_drop,
      iconColor: Colors.red,
      onTap: () => MapService.openMap(locationCoordinates),
      height: height,
    );
  }

  /// Post owner display
  static Widget postOwner(BuildContext context, String username, String uid,
      {double height = 20}) {
    return PostAttribute(
      title: "Posted by $username",
      iconData:Icons.account_circle,
      onTap: () {
        NavigatorService.openPage(UserProfile(viewingUID: uid), false);

      },
      height: height,
    );
  }

  /// Time since post
  static Widget since(int timestamp, {double height = 20}) {
    return PostAttribute(
      title: "Since ${timeago.format(DateTime.fromMillisecondsSinceEpoch(timestamp))}",
      iconData: Icons.history,
      height: height,
    );
  }

  /// Phone number
  static Widget phoneNumber(String phone, {double height = 20}) {
    return PostAttribute(
      title: phone,
      iconData: Icons.phone,
      height: height,
    );
  }

  /// Email
  static Widget email(String email, {double height = 20}) {
    return PostAttribute(
      title: email,
      iconData:Icons.email,
      height: height,
    );
  }

  /// Post title
  static Widget postTitle(String title, {double height = 20}) {
    return PostAttribute(
      title: title,
      iconData: Icons.title,
      height: height,
    );
  }

  /// Description
  static Widget description(String description, {double height = 100}) {
    return PostAttribute(
      title: description.isEmpty? "No description...":description,
      iconData: Icons.info,
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
            Align(
              alignment: Alignment.topLeft,
              child:Icon(iconData,size:20,color:iconColor),
            ),
            Flexible(
              child:Align(
                alignment: Alignment.topLeft,
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
              )

            ),


          ],
        ),
      ),
    );
  }
}
