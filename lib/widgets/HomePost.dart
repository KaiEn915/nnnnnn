import 'package:flutter/material.dart';
import 'package:gan/pages/MyMap.dart';
import 'package:gan/widgets/HomePostAttribute.dart';
import 'package:gan/services/GeoLocator.dart';
import 'package:geolocator/geolocator.dart';

class HomePost extends StatefulWidget{
  const HomePost(
      {
        super.key,
        required this.postData
      });
  final Map<String, dynamic> postData;

  @override
  State<StatefulWidget> createState() =>_HomePostState();
}

class _HomePostState extends State<HomePost> {



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white.withAlpha(192),
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
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            runSpacing: 10,
            children: [
              HomePostAttribute(
                title: "Since 7 hours ago",
                icon: Icon(Icons.history, size: 20),
              ),
              HomePostAttribute(
                title: widget.postData['title']??" ",
              ),
              Container(
                width: 350,
                height: 196,
                child: Image.asset("assets/images/cat.png"),
              ),
              HomePostAttribute(
                title: "Near ${widget.postData['location']}",
                icon: Icon(Icons.pin_drop, color: Colors.red, size: 20),
                onTap: () async
                {
                  Position pos = await determinePosition();
                  print(pos);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyMap(isPromptingLocation: false,initialPosition: pos),
                    ),
                  );
                },
              ),
              HomePostAttribute(
                title: "Posted by ${widget.postData['username']}",
                icon: Icon(Icons.account_circle, size: 20),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
