import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gan/pages/PostDetail.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/ImageService.dart';
import 'package:gan/utils/OurUI.dart';
import 'package:flutter/material.dart';
import 'package:gan/widgets/PostAttribute.dart';

class HomePost extends StatefulWidget {
  const HomePost({super.key, required this.id});
  final String id;



  @override
  State<StatefulWidget> createState() => _HomePostState();
}

class _HomePostState extends State<HomePost> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.db.collection("posts").doc(widget.id).get(),
        builder: (context,postSnapshot){
          if (!postSnapshot.hasData)
            return CircularProgressIndicator();
          final postData=postSnapshot.data;
          return FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
              future: AuthService.db.collection('users').doc(postData?['owner_uid']).get(),
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
                              PostDetail(id: postData?['id']),
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
                        PostAttribute.since(postData?['timestamp']),
                        PostAttribute.postTitle(postData?['title']),
                        Container(
                            width: 350,
                            height: 196,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[200],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: ImageService.tryDisplayImage(postData?['imageData']??"",196)
                        ),
                        PostAttribute.description(postData?['description']),
                        FutureBuilder<Widget>(
                          future: PostAttribute.address(context,postData?['locationCoordinates']),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return PostAttribute(title: "Loading address...", iconData:Icons.pin_drop, iconColor: Colors.grey);
                            } else if (snapshot.hasError) {
                              return PostAttribute(title: "Location unavailable", iconData: Icons.error, iconColor: Colors.red);
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
          );
    });
  }
}
