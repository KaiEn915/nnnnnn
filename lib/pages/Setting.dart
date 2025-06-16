import 'package:flutter/material.dart';
import 'package:gan/widgets/LabeledInputBox.dart';
import 'package:gan/widgets/LabeledInputBox.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

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
              image: AssetImage("assets/images/background3.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                //the button for save change
                left: 85,
                top: 780,
                child: Container(
                  width: 250,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Save Changes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 350,
                child: Container(
                  width: 300,
                  height: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    spacing: 9,
                    runSpacing: 8,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.red),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          spacing: 9,
                          children: [
                            Container(
                              child: Text(
                                'First Name:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 1.40,
                                ),
                              ),
                            ),
                            Container(
                              child: Container(
                                width: 320,
                                height: 30,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(0xFFDFDFDF),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          labelText: '用户名',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/images/pencil.png",
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Text(
                      //   'Last Name:',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 20,
                      //     fontFamily: 'Inter',
                      //     fontWeight: FontWeight.w400,
                      //     height: 1.40,
                      //   ),
                      // ),
                      // Container(
                      //   width: 320,
                      //   height: 30,
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 16,
                      //     vertical: 10,
                      //   ),
                      //   decoration: ShapeDecoration(
                      //     color: Colors.white,
                      //     shape: RoundedRectangleBorder(
                      //       side: BorderSide(
                      //         width: 1,
                      //         color: const Color(0xFFDFDFDF),
                      //       ),
                      //       borderRadius: BorderRadius.circular(8),
                      //     ),
                      //   ),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     spacing: 10,
                      //     children: [
                      //       SizedBox(
                      //         width: 262,
                      //         child: Text(
                      //           'Kiat Meng',
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //             color: const Color(0xFF828282),
                      //             fontSize: 20,
                      //             fontFamily: 'Inter',
                      //             fontWeight: FontWeight.w400,
                      //             height: 1.40,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 16,
                      //         height: 16,
                      //         decoration: BoxDecoration(
                      //           image: DecorationImage(
                      //             image: AssetImage(
                      //               "https://placehold.co/16x16",
                      //             ),
                      //             fit: BoxFit.contain,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Text(
                      //   'Bio:',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 20,
                      //     fontFamily: 'Inter',
                      //     fontWeight: FontWeight.w400,
                      //     height: 1.40,
                      //   ),
                      // ),
                      // Container(
                      //   width: 320,
                      //   height: 53,
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 16,
                      //     vertical: 10,
                      //   ),
                      //   decoration: ShapeDecoration(
                      //     color: Colors.white,
                      //     shape: RoundedRectangleBorder(
                      //       side: BorderSide(
                      //         width: 1,
                      //         color: const Color(0xFFDFDFDF),
                      //       ),
                      //       borderRadius: BorderRadius.circular(8),
                      //     ),
                      //   ),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     spacing: 10,
                      //     children: [
                      //       SizedBox(
                      //         width: 262,
                      //         child: Text(
                      //           'Hello guys welcome to my YouTube channel!',
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //             color: const Color(0xFF828282),
                      //             fontSize: 10,
                      //             fontFamily: 'Inter',
                      //             fontWeight: FontWeight.w400,
                      //             height: 1.40,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 16,
                      //         height: 16,
                      //         decoration: BoxDecoration(
                      //           image: DecorationImage(
                      //             image: AssetImage(
                      //               "https://placehold.co/16x16",
                      //             ),
                      //             fit: BoxFit.contain,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 68,
                      //   height: 30,
                      //   child: Text(
                      //     'Location: ',
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 20,
                      //       fontFamily: 'Inter',
                      //       fontWeight: FontWeight.w400,
                      //       height: 1.40,
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   width: 184,
                      //   height: 30,
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 16,
                      //     vertical: 10,
                      //   ),
                      //   decoration: ShapeDecoration(
                      //     color: Colors.white,
                      //     shape: RoundedRectangleBorder(
                      //       side: BorderSide(
                      //         width: 1,
                      //         color: const Color(0xFFDFDFDF),
                      //       ),
                      //       borderRadius: BorderRadius.circular(8),
                      //     ),
                      //   ),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     spacing: 10,
                      //     children: [
                      //       SizedBox(
                      //         width: 126,
                      //         child: Text(
                      //           'Johor Bahru',
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //             color: const Color(0xFF828282),
                      //             fontSize: 20,
                      //             fontFamily: 'Inter',
                      //             fontWeight: FontWeight.w400,
                      //             height: 1.40,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 16,
                      //         height: 16,
                      //         decoration: BoxDecoration(
                      //           image: DecorationImage(
                      //             image: AssetImage(
                      //               "https://placehold.co/16x16",
                      //             ),
                      //             fit: BoxFit.contain,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   width: 320,
                      //   clipBehavior: Clip.antiAlias,
                      //   decoration: BoxDecoration(),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     spacing: 9,
                      //     children: [
                      //       SizedBox(
                      //         width: 266,
                      //         child: Text(
                      //           'Enable post notifications',
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 20,
                      //             fontFamily: 'Inter',
                      //             fontWeight: FontWeight.w400,
                      //             height: 1.40,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 28,
                      //         height: 19,
                      //         decoration: BoxDecoration(
                      //           image: DecorationImage(
                      //             image: AssetImage(
                      //               "https://placehold.co/28x19",
                      //             ),
                      //             fit: BoxFit.contain,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   width: 320,
                      //   clipBehavior: Clip.antiAlias,
                      //   decoration: BoxDecoration(),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     spacing: 9,
                      //     children: [
                      //       SizedBox(
                      //         width: 266,
                      //         child: Text(
                      //           'Enable nearby missing pet notifications',
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 20,
                      //             fontFamily: 'Inter',
                      //             fontWeight: FontWeight.w400,
                      //             height: 1.40,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 28,
                      //         height: 19,
                      //         decoration: BoxDecoration(
                      //           image: DecorationImage(
                      //             image: AssetImage(
                      //               "https://placehold.co/28x19",
                      //             ),
                      //             fit: BoxFit.contain,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   width: 320,
                      //   clipBehavior: Clip.antiAlias,
                      //   decoration: BoxDecoration(),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     spacing: 9,
                      //     children: [
                      //       SizedBox(
                      //         width: 266,
                      //         child: Text(
                      //           'Enable group chat messages',
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 20,
                      //             fontFamily: 'Inter',
                      //             fontWeight: FontWeight.w400,
                      //             height: 1.40,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 28,
                      //         height: 19,
                      //         decoration: BoxDecoration(
                      //           image: DecorationImage(
                      //             image: AssetImage(
                      //               "https://placehold.co/28x19",
                      //             ),
                      //             fit: BoxFit.contain,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 114.50,
                top: 93,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 13,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE6FCFF),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 117,
                        height: 118,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage("https://placehold.co/117x118"),
                            fit: BoxFit.contain,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
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
                      ),
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("https://placehold.co/16x16"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 7.50,
                top: 16,
                child: Container(
                  width: 360,
                  height: 65,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white.withValues(alpha: 191),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Container(
                        width: 37,
                        height: 37,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white.withValues(alpha: 128),
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
                        child: Stack(
                          children: [
                            Positioned(
                              left: 7,
                              top: 8,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/UserProfile',
                                  );
                                },
                                child: Icon(Icons.arrow_back, size: 30),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 244,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white.withValues(alpha: 128),
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 48,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: SizedBox(
                                      width: 244,
                                      height: 48,
                                      child: Text(
                                        'SETTINGS',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'IBM Plex Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 1,
                                          letterSpacing: 3,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(0, 4),
                                              blurRadius: 4,
                                              color: Color(
                                                0xFF000000,
                                              ).withOpacity(0.25),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    );
  }
}
