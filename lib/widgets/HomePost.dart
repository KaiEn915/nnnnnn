import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gan/pages/PostDetail.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/ImageService.dart';
import 'package:gan/utils/OurUI.dart';
import 'package:flutter/material.dart';
import 'package:gan/widgets/PostAttribute.dart';
import 'package:gan/services/MapService.dart';

class HomePost extends StatefulWidget {
  const HomePost({super.key, required this.postData});

  final Map<String, dynamic> postData;

  @override
  State<StatefulWidget> createState() => _HomePostState();
}

class _HomePostState extends State<HomePost> {
  String address = "";

  @override
  void initState() {
    super.initState();
    loadAddress();
  }

  void loadAddress() async {
    final address = await MapService.getAddressFromCoordinates(
      widget.postData['locationCoordinates'],
    );
    setState(() {
      this.address = "Near $address";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
            future: AuthService.db.collection('users').doc(widget.postData['owner_uid']).get(),
            builder: (context,snapshot){
              if(!snapshot.hasData) return Center(child:CircularProgressIndicator());
              final userData=snapshot.data!.data();
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                clipBehavior: Clip.antiAlias,
                decoration: OurUI.shapeDecoration(),
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            PostDetail(id: widget.postData['id']),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        transitionDuration: Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    runSpacing: 10,
                    children: [
                      PostAttribute.since(widget.postData['timestamp']),
                      PostAttribute.postTitle(widget.postData['title']),
                      Container(
                          width: 350,
                          height: 196,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[200],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ImageService.tryDisplayImage(widget.postData['imageData']??"",196)
                      ),
                      FutureBuilder<Widget>(
                        future: PostAttribute.address(context,widget.postData['locationCoordinates']),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return PostAttribute(title: "Loading address...", icon: Icon(Icons.pin_drop, color: Colors.grey));
                          } else if (snapshot.hasError) {
                            return PostAttribute(title: "Location unavailable", icon: Icon(Icons.error, color: Colors.red));
                          } else {
                            return snapshot.data!;
                          }
                        },
                      ),

                      PostAttribute.postOwner(context, userData?['username'], userData?['uid'])
                      ,
                    ],
                  ),
                ),
              );
            }
        ),


        const SizedBox(height: 20),
      ],
    );
  }
}
