import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/MyMap.dart';
import 'package:gan/widgets/PostAttribute.dart';
import 'package:gan/services/MapService.dart';
import 'package:latlong2/latlong.dart';
class SimilarPetPost extends StatefulWidget{
  const SimilarPetPost(
      {
        super.key,
        required this.postData
      });
  final Map<String, dynamic> postData;

  @override
  State<StatefulWidget> createState() =>_SimilarPetPostState();
}

class _SimilarPetPostState extends State<SimilarPetPost> {
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
    return Container(
      margin: EdgeInsets.all(5),
      decoration: ShapeDecoration(
        color: Colors.white.withAlpha(128),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.50,
            color: const Color(0xFF008082),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Container(
        height: 170,
        clipBehavior: Clip.none,
        margin: EdgeInsets.all(15),
        decoration: ShapeDecoration(
          color: Colors.white.withAlpha(128),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.50,
              color: const Color(0xFF008082),
            ),
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.all(
                5,
              ),
              child: Column(
                children: [
                  Container(
                    height: 20,
                    child: Row(
                      mainAxisSize:
                      MainAxisSize.min,
                      spacing: 4,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: Colors.red,
                        ),
                        Flexible(child:
                        Text(
                          "Near $address",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                            fontFamily: 'Inter',
                            fontWeight:
                            FontWeight.w600,
                            decoration:
                            TextDecoration
                                .none,
                          ),
                        ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/cat.png",
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        Row(
                          spacing: 5,
                          children: [
                            Icon(
                              Icons
                                  .account_circle,
                            ),
                            Text(
                              'Posted by ${widget.postData['username']??'Unknown'}',
                              style: TextStyle(
                                color:
                                Colors.black,
                                fontSize: 8,
                                fontFamily:
                                'Inter',
                                fontWeight:
                                FontWeight
                                    .w600,
                                decoration:
                                TextDecoration
                                    .none,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            Icon(Icons.history),
                            Text(
                              "Since ${timeago.format(DateTime.fromMillisecondsSinceEpoch(widget.postData['timestamp']))}",
                              style: TextStyle(
                                color:
                                Colors.black,
                                fontSize: 8,
                                fontFamily:
                                'Inter',
                                fontWeight:
                                FontWeight
                                    .w600,
                                height: 0,
                                decoration:
                                TextDecoration
                                    .none,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top:-20,
              right:-20,
              child: Image(
                image: AssetImage(
                  "assets/images/redPin.png",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
