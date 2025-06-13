import 'package:flutter/material.dart';

class GroupChatPost extends StatelessWidget {
  const GroupChatPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //调group chat 里面的大小
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
              )
            ],
          ),
          child: Stack(
            children: [
              Container(
                width: 370,
                height: 102,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(0),
                  image: DecorationImage(
                    image: AssetImage("assets/images/GroupChatBackgroud.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      //groudchat 的头像
                      image: AssetImage("assets/images/"),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 5,
                top: 57,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/PokemonBall.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 50,
                top: 40,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      //显示有没有人在线的
                      image: AssetImage("assets/images/"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 65,
                child: SizedBox(
                  width: 140,
                  height: 29,
                  child: Text(
                    'Pet Status: Missing',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 190,
                top: 60,
                child: Icon(
                  Icons.account_circle,
                ),
              ),
              Positioned(
                left: 215,
                top: 65,
                child: SizedBox(
                  width: 117,
                  height: 29,
                  child: Text(
                    '3 / 100',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 80,
                top: 52,
                child: SizedBox(
                  width: 290,
                  height: 12,
                  child: Text(
                    '3 onlines',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 64.50,
                top: 13,
                child: SizedBox(
                  width: 277,
                  height: 19,
                  child: Text(
                    'Goh Kiat Meng’s Group Chat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}