import 'package:flutter/material.dart';

class HomePostAttribute extends StatelessWidget{
  final String title;
  final Icon? icon;
  final VoidCallback? onTap;
  const HomePostAttribute({super.key,required this.title,this.icon,this.onTap});


  @override
  Widget build(BuildContext context){
    return Container(
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
          spacing:5,
          children: [
            Container(
              child: icon,
            ),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }


}