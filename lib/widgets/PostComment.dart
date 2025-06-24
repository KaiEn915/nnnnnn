import 'package:flutter/material.dart';
import 'package:gan/pages/UserProfile.dart';

class PostComment extends StatelessWidget {
  const PostComment({
    super.key,
    required this.uid,
    required this.username,
    required this.content,
    required this.profileIconImageData,
  });

  final String uid;
  final String username;
  final String content;
  final String profileIconImageData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfile(viewingUID: uid)),
        );
      },
      child: Container(
        width: 300,
        height: 50,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white.withValues(alpha: 128),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://placehold.co/32x32"),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.10),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 40,
              top: 0,
              right: 0,
              child: Container(
                height: 15,
                alignment: Alignment.topLeft,
                child: Text(
                  username,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Iceland',
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 45,
              right: 0,
              top: 15,
              bottom: 0,
              child: Container(
                alignment: Alignment.topLeft,
                height: 30,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Text(
                      content,
                      style: TextStyle(
                        color: Color(0xFF828282),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
