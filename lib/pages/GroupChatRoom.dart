import 'package:flutter/material.dart';
import 'package:gan/widgets/LabeledInputBox.dart';
import 'package:gan/widgets/TopBar.dart';

class GroupChatRoom extends StatefulWidget {
  const GroupChatRoom({super.key});

  @override
  State<GroupChatRoom> createState() => _GroupChatRoomWidgetState();
}

class _GroupChatRoomWidgetState extends State<GroupChatRoom> {
  late TextEditingController ChatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background2.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Positioned(
                //   left: 1,
                //   top: 81,
                //   child: Container(
                //     width: 374,
                //     height: 536,
                //     clipBehavior: Clip.antiAlias,
                //     decoration: BoxDecoration(),
                //     child: Stack(
                //       children: [
                //         Container(
                //           width: 171,
                //           height: 46,
                //           child: Stack(
                //             children: [
                //               Positioned(
                //                 left: 0,
                //                 top: 0,
                //                 child: Container(
                //                   width: 46,
                //                   height: 46,
                //                   decoration: ShapeDecoration(
                //                     image: DecorationImage(
                //                       image: AssetImage(
                //                         "https://placehold.co/46x46",
                //                       ),
                //                       fit: BoxFit.cover,
                //                     ),
                //                     shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(100),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 left: 45,
                //                 top: 20,
                //                 child: Container(
                //                   width: 19,
                //                   height: 26,
                //                   child: Column(
                //                     mainAxisSize: MainAxisSize.min,
                //                     mainAxisAlignment: MainAxisAlignment.start,
                //                     crossAxisAlignment: CrossAxisAlignment.end,
                //                     children: [
                //                       Expanded(
                //                         child: Container(
                //                           width: 16,
                //                           decoration: ShapeDecoration(
                //                             color: Colors.white,
                //                             shape: RoundedRectangleBorder(
                //                               side: BorderSide(
                //                                 width: 0.50,
                //                                 color: const Color(0xFF9BA9B0),
                //                               ),
                //                               borderRadius: BorderRadius.only(
                //                                 topLeft: Radius.circular(100),
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 left: 63,
                //                 top: 20,
                //                 child: Container(
                //                   width: 85,
                //                   height: 26,
                //                   padding: const EdgeInsets.symmetric(
                //                     horizontal: 10,
                //                   ),
                //                   decoration: ShapeDecoration(
                //                     color: Colors.white,
                //                     shape: RoundedRectangleBorder(
                //                       side: BorderSide(
                //                         width: 0.50,
                //                         color: const Color(0xFF9BA9B0),
                //                       ),
                //                       borderRadius: BorderRadius.only(
                //                         topRight: Radius.circular(24),
                //                         bottomRight: Radius.circular(24),
                //                       ),
                //                     ),
                //                   ),
                //                   child: Stack(
                //                     children: [
                //                       Positioned(
                //                         left: 50,
                //                         top: 12,
                //                         child: Container(
                //                           width: 22,
                //                           padding: const EdgeInsets.symmetric(
                //                             vertical: 1,
                //                           ),
                //                           child: Row(
                //                             mainAxisSize: MainAxisSize.min,
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.center,
                //                             crossAxisAlignment:
                //                                 CrossAxisAlignment.center,
                //                             spacing: 10,
                //                             children: [
                //                               Text(
                //                                 '2:00pm',
                //                                 textAlign: TextAlign.right,
                //                                 style: TextStyle(
                //                                   color: const Color(
                //                                     0xFF7E909A,
                //                                   ),
                //                                   fontSize: 10,
                //                                   fontFamily: 'ABeeZee',
                //                                   fontWeight: FontWeight.w400,
                //                                   letterSpacing: -0.41,
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                       Positioned(
                //                         left: 0,
                //                         top: 2,
                //                         child: Text(
                //                           'Hello',
                //                           style: TextStyle(
                //                             color: const Color(0xFF21272A),
                //                             fontSize: 17,
                //                             fontFamily: 'ABeeZee',
                //                             fontWeight: FontWeight.w400,
                //                             height: 1.29,
                //                             letterSpacing: -0.41,
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 left: 48,
                //                 top: 0,
                //                 child: SizedBox(
                //                   width: 123,
                //                   height: 20,
                //                   child: Text(
                //                     'Hue Zhi En',
                //                     style: TextStyle(
                //                       color: Colors.black,
                //                       fontSize: 12,
                //                       fontFamily: 'ABeeZee',
                //                       fontWeight: FontWeight.w400,
                //                       height: 1.40,
                //                       letterSpacing: -0.41,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Container(
                //           width: 171,
                //           height: 46,
                //           child: Stack(
                //             children: [
                //               Positioned(
                //                 left: 0,
                //                 top: 0,
                //                 child: Container(
                //                   width: 46,
                //                   height: 46,
                //                   decoration: ShapeDecoration(
                //                     image: DecorationImage(
                //                       image: AssetImage(
                //                         "https://placehold.co/46x46",
                //                       ),
                //                       fit: BoxFit.cover,
                //                     ),
                //                     shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(100),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 left: 45,
                //                 top: 20,
                //                 child: Container(
                //                   width: 19,
                //                   height: 26,
                //                   child: Column(
                //                     mainAxisSize: MainAxisSize.min,
                //                     mainAxisAlignment: MainAxisAlignment.start,
                //                     crossAxisAlignment: CrossAxisAlignment.end,
                //                     children: [
                //                       Expanded(
                //                         child: Container(
                //                           width: 16,
                //                           decoration: ShapeDecoration(
                //                             color: Colors.white,
                //                             shape: RoundedRectangleBorder(
                //                               side: BorderSide(
                //                                 width: 0.50,
                //                                 color: const Color(0xFF9BA9B0),
                //                               ),
                //                               borderRadius: BorderRadius.only(
                //                                 topLeft: Radius.circular(100),
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 left: 63,
                //                 top: 20,
                //                 child: Container(
                //                   width: 85,
                //                   height: 26,
                //                   padding: const EdgeInsets.symmetric(
                //                     horizontal: 10,
                //                   ),
                //                   decoration: ShapeDecoration(
                //                     color: Colors.white,
                //                     shape: RoundedRectangleBorder(
                //                       side: BorderSide(
                //                         width: 0.50,
                //                         color: const Color(0xFF9BA9B0),
                //                       ),
                //                       borderRadius: BorderRadius.only(
                //                         topRight: Radius.circular(24),
                //                         bottomRight: Radius.circular(24),
                //                       ),
                //                     ),
                //                   ),
                //                   child: Stack(
                //                     children: [
                //                       Positioned(
                //                         left: 50,
                //                         top: 12,
                //                         child: Container(
                //                           width: 22,
                //                           padding: const EdgeInsets.symmetric(
                //                             vertical: 1,
                //                           ),
                //                           child: Row(
                //                             mainAxisSize: MainAxisSize.min,
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.center,
                //                             crossAxisAlignment:
                //                                 CrossAxisAlignment.center,
                //                             spacing: 10,
                //                             children: [
                //                               Text(
                //                                 '2:01pm',
                //                                 textAlign: TextAlign.right,
                //                                 style: TextStyle(
                //                                   color: const Color(
                //                                     0xFF7E909A,
                //                                   ),
                //                                   fontSize: 10,
                //                                   fontFamily: 'ABeeZee',
                //                                   fontWeight: FontWeight.w400,
                //                                   letterSpacing: -0.41,
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                       Positioned(
                //                         left: 0,
                //                         top: 2,
                //                         child: Text(
                //                           'Hi',
                //                           style: TextStyle(
                //                             color: const Color(0xFF21272A),
                //                             fontSize: 17,
                //                             fontFamily: 'ABeeZee',
                //                             fontWeight: FontWeight.w400,
                //                             height: 1.29,
                //                             letterSpacing: -0.41,
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 left: 48,
                //                 top: 0,
                //                 child: SizedBox(
                //                   width: 123,
                //                   height: 20,
                //                   child: Text(
                //                     'Hue Zhi En',
                //                     style: TextStyle(
                //                       color: Colors.black,
                //                       fontSize: 12,
                //                       fontFamily: 'ABeeZee',
                //                       fontWeight: FontWeight.w400,
                //                       height: 1.40,
                //                       letterSpacing: -0.41,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Container(
                //           width: 171,
                //           height: 46,
                //           child: Stack(
                //             children: [
                //               Positioned(
                //                 left: 0,
                //                 top: 0,
                //                 child: Container(
                //                   width: 46,
                //                   height: 46,
                //                   decoration: ShapeDecoration(
                //                     image: DecorationImage(
                //                       image: AssetImage(
                //                         "https://placehold.co/46x46",
                //                       ),
                //                       fit: BoxFit.cover,
                //                     ),
                //                     shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(100),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 left: 45,
                //                 top: 20,
                //                 child: Container(
                //                   width: 19,
                //                   height: 26,
                //                   child: Column(
                //                     mainAxisSize: MainAxisSize.min,
                //                     mainAxisAlignment: MainAxisAlignment.start,
                //                     crossAxisAlignment: CrossAxisAlignment.end,
                //                     children: [
                //                       Expanded(
                //                         child: Container(
                //                           width: 16,
                //                           decoration: ShapeDecoration(
                //                             color: Colors.white,
                //                             shape: RoundedRectangleBorder(
                //                               side: BorderSide(
                //                                 width: 0.50,
                //                                 color: const Color(0xFF9BA9B0),
                //                               ),
                //                               borderRadius: BorderRadius.only(
                //                                 topLeft: Radius.circular(100),
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 left: 63,
                //                 top: 20,
                //                 child: Container(
                //                   width: 85,
                //                   height: 26,
                //                   padding: const EdgeInsets.symmetric(
                //                     horizontal: 10,
                //                   ),
                //                   decoration: ShapeDecoration(
                //                     color: Colors.white,
                //                     shape: RoundedRectangleBorder(
                //                       side: BorderSide(
                //                         width: 0.50,
                //                         color: const Color(0xFF9BA9B0),
                //                       ),
                //                       borderRadius: BorderRadius.only(
                //                         topRight: Radius.circular(24),
                //                         bottomRight: Radius.circular(24),
                //                       ),
                //                     ),
                //                   ),
                //                   child: Stack(
                //                     children: [
                //                       Positioned(
                //                         left: 50,
                //                         top: 12,
                //                         child: Container(
                //                           width: 22,
                //                           padding: const EdgeInsets.symmetric(
                //                             vertical: 1,
                //                           ),
                //                           child: Row(
                //                             mainAxisSize: MainAxisSize.min,
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.center,
                //                             crossAxisAlignment:
                //                                 CrossAxisAlignment.center,
                //                             spacing: 10,
                //                             children: [
                //                               Text(
                //                                 '2:02pm',
                //                                 textAlign: TextAlign.right,
                //                                 style: TextStyle(
                //                                   color: const Color(
                //                                     0xFF7E909A,
                //                                   ),
                //                                   fontSize: 10,
                //                                   fontFamily: 'ABeeZee',
                //                                   fontWeight: FontWeight.w400,
                //                                   letterSpacing: -0.41,
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                       Positioned(
                //                         left: 0,
                //                         top: 2,
                //                         child: Text(
                //                           'OO',
                //                           style: TextStyle(
                //                             color: const Color(0xFF21272A),
                //                             fontSize: 17,
                //                             fontFamily: 'ABeeZee',
                //                             fontWeight: FontWeight.w400,
                //                             height: 1.29,
                //                             letterSpacing: -0.41,
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 left: 48,
                //                 top: 0,
                //                 child: SizedBox(
                //                   width: 123,
                //                   height: 20,
                //                   child: Text(
                //                     'Hue Zhi En',
                //                     style: TextStyle(
                //                       color: Colors.black,
                //                       fontSize: 12,
                //                       fontFamily: 'ABeeZee',
                //                       fontWeight: FontWeight.w400,
                //                       height: 1.40,
                //                       letterSpacing: -0.41,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Positioned(
                //           left: 93,
                //           top: 238,
                //           child: Container(
                //             width: 279,
                //             height: 46,
                //             child: Stack(
                //               children: [
                //                 Positioned(
                //                   left: 233,
                //                   top: 0,
                //                   child: Container(
                //                     width: 46,
                //                     height: 46,
                //                     decoration: ShapeDecoration(
                //                       image: DecorationImage(
                //                         image: AssetImage(
                //                           "https://placehold.co/46x46",
                //                         ),
                //                         fit: BoxFit.cover,
                //                       ),
                //                       shape: RoundedRectangleBorder(
                //                         borderRadius: BorderRadius.circular(
                //                           100,
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //                 Positioned(
                //                   left: 233,
                //                   top: 46,
                //                   child: Container(
                //                     transform: Matrix4.identity()
                //                       ..translate(0.0, 0.0)
                //                       ..rotateZ(3.14),
                //                     height: 46,
                //                     child: Column(
                //                       mainAxisSize: MainAxisSize.min,
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.start,
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.end,
                //                       children: [
                //                         Expanded(
                //                           child: Container(
                //                             width: 16,
                //                             decoration: ShapeDecoration(
                //                               color: const Color(0xFFE7FECC),
                //                               shape: RoundedRectangleBorder(
                //                                 side: BorderSide(
                //                                   width: 0.50,
                //                                   color: const Color(
                //                                     0xFF9BA9B0,
                //                                   ),
                //                                 ),
                //                                 borderRadius: BorderRadius.only(
                //                                   topLeft: Radius.circular(100),
                //                                 ),
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //                 Positioned(
                //                   left: -73,
                //                   top: 0,
                //                   child: Container(
                //                     width: 288,
                //                     height: 46,
                //                     decoration: ShapeDecoration(
                //                       color: const Color(0xFFE7FECC),
                //                       shape: RoundedRectangleBorder(
                //                         side: BorderSide(
                //                           width: 0.50,
                //                           color: const Color(0xFF9BA9B0),
                //                         ),
                //                         borderRadius: BorderRadius.only(
                //                           topLeft: Radius.circular(24),
                //                           bottomLeft: Radius.circular(24),
                //                         ),
                //                       ),
                //                     ),
                //                     child: Stack(
                //                       children: [
                //                         Positioned(
                //                           left: 19,
                //                           top: 8,
                //                           child: SizedBox(
                //                             width: 207,
                //                             height: 33,
                //                             child: Text(
                //                               'ABCDEFGHIJKLMNOPQRST\nUVWXYZ',
                //                               style: TextStyle(
                //                                 color: const Color(0xFF21272A),
                //                                 fontSize: 17,
                //                                 fontFamily: 'ABeeZee',
                //                                 fontWeight: FontWeight.w400,
                //                                 height: 1.29,
                //                                 letterSpacing: -0.41,
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                         Positioned(
                //                           left: 226,
                //                           top: 30,
                //                           child: Row(
                //                             mainAxisSize: MainAxisSize.min,
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.end,
                //                             crossAxisAlignment:
                //                                 CrossAxisAlignment.center,
                //                             spacing: 4,
                //                             children: [
                //                               Text(
                //                                 '2:05pm',
                //                                 style: TextStyle(
                //                                   color: const Color(
                //                                     0xFF439635,
                //                                   ),
                //                                   fontSize: 12,
                //                                   fontFamily: 'ABeeZee',
                //                                   fontWeight: FontWeight.w400,
                //                                   letterSpacing: -0.41,
                //                                 ),
                //                               ),
                //                               Container(
                //                                 width: 16,
                //                                 height: 16,
                //                                 clipBehavior: Clip.antiAlias,
                //                                 decoration: BoxDecoration(),
                //                                 child: Stack(),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //                 Positioned(
                //                   left: 107,
                //                   top: -20,
                //                   child: SizedBox(
                //                     width: 123,
                //                     height: 20,
                //                     child: Text(
                //                       'You',
                //                       textAlign: TextAlign.right,
                //                       style: TextStyle(
                //                         color: Colors.black,
                //                         fontSize: 12,
                //                         fontFamily: 'ABeeZee',
                //                         fontWeight: FontWeight.w400,
                //                         height: 1.40,
                //                         letterSpacing: -0.41,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 67,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/blue.png"),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 5,
                        bottom: 5,
                      ),
                      height: 60,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        //里面的蓝色
                        color: const Color(0xBFE9FBFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 10,
                        children: [
                          Container(
                            width: 300,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Your Text",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Container(
                            width: 35,
                            height: 39,
                            child: Icon(
                              Icons.file_upload_outlined,
                            ),
                          ),
                          Container(
                            width: 35,
                            height: 39,
                            child: Icon(
                              Icons.send,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                TopBar(
                  isMiddleSearchBar: false,
                  header: "GROUPCHAT",
                  leftIcon: Icons.arrow_back,
                  leftIcon_onTap: () => {
                    Navigator.pushNamed(context, "/GroupChat"),
                  },
                  rightIcon: Icons.error_outline,
                  rightIcon_onTap: () => {
                    Navigator.pushNamed(context, "/GroupChatDetail"),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
