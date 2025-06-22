import 'package:gan/pages/UserProfile.dart';
import 'package:gan/services/AuthService.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/MyMap.dart';
import 'package:gan/widgets/HomePostAttribute.dart';
import 'package:gan/services/MapService.dart';
import 'package:latlong2/latlong.dart';
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
  String address="";
  @override
  void initState() {
    super.initState();
    loadAddress();
  }

  void loadAddress() async {
    final address = await MapService.getAddressFromCoordinates(widget.postData['locationCoordinates']);
    setState(() {
      this.address = "Near $address";
    });
  }



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
                title: "Since ${timeago.format(DateTime.fromMillisecondsSinceEpoch(widget.postData['timestamp']))}",
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
                title: "Near $address",
                icon: Icon(Icons.pin_drop, color: Colors.red, size: 20),
                  onTap: () async {
                    try {
                      final coordinates = widget.postData['locationCoordinates'];


                      // Navigate to the map without picking mode
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyMap(
                            isPickingLocation: false,
                            initialCoordinates: LatLng(coordinates.latitude, coordinates.longitude),
                          ),
                        ),
                      );
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: "Failed to open map: $e",
                        backgroundColor: Colors.red,
                      );
                    }
                  }
,
              ),
              HomePostAttribute(
                title: "Posted by ${widget.postData['username']}",
                icon: Icon(Icons.account_circle, size: 20),
                onTap: (){
                  if (widget.postData['uid']!=AuthService.uid){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => UserProfile(viewingUID: widget.postData['uid'])
                    ));
                    Fluttertoast.showToast(msg: "Viewing user: ${widget.postData['username']}");
                  }
                  else{
                    Fluttertoast.showToast(msg: "You are the post user...");
                  }
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
