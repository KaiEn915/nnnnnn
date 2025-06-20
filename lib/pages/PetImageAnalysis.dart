import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gan/widgets/TopBar.dart';

class PetImageAnalysis extends StatefulWidget {
  const PetImageAnalysis({super.key, required this.image});

  final XFile image;

  @override
  State<StatefulWidget> createState() => _PetImageAnalysisState();
}

class _PetImageAnalysisState extends State<PetImageAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Positioned(
            left: 19,
            top: 100,
            child: Container(
              width: 332,
              height: 564,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 64),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  Container(
                    width: double.infinity,
                    height: 125,
                    decoration: ShapeDecoration(
                      color: const Color(0xBFEAF9F6),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.25),
                        borderRadius: BorderRadius.circular(25),
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
                          left: 21,
                          top: 14,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://placehold.co/100x100",
                                ),
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 125,
                          top: 15,
                          child: Container(
                            width: 164,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 164,
                                  height: 40,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: SizedBox(
                                          width: 164,
                                          height: 40,
                                          child: Text(
                                            'POSSIBLE BREED',
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
                                SizedBox(
                                  width: 164,
                                  height: 57,
                                  child: Text(
                                    'Welsh Corgi',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFF005267),
                                      fontSize: 24,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      height: 1.50,
                                      letterSpacing: -0.24,
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
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 316,
                          top: -6,
                          child: Container(
                            width: 19.19,
                            height: 20,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://placehold.co/19x20",
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 116,
                          top: 112,
                          child: Container(
                            width: 60,
                            height: 20,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://placehold.co/60x20",
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0x7FFFFEF3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 292,
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: ShapeDecoration(
                            color: const Color(0x7FF8F9F4),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Container(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(3.14),
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://placehold.co/32x32",
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 192,
                                height: 72,
                                child: Text(
                                  'SIMILAR PETS',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontFamily: 'IBM Plex Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                    letterSpacing: 3.30,
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
                              Container(
                                width: 32,
                                height: 49,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://placehold.co/32x49",
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 299,
                          height: 353,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 8,
                                top: 15,
                                child: Container(
                                  width: 283,
                                  height: 199,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://placehold.co/283x199",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 0.15,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 265,
                                        top: 0,
                                        child: Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                "https://placehold.co/18x18",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 15,
                                        top: 16,
                                        child: Container(
                                          width: 253,
                                          height: 167,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            color: Colors.white.withValues(
                                              alpha: 128,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 0.50,
                                                color: const Color(0xFF008082),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                                left: 39,
                                                top: 0,
                                                child: Container(
                                                  width: 175,
                                                  height: 23,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(),
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 0,
                                                        top: 4,
                                                        child: Container(
                                                          width: 16,
                                                          height: 16,
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              image: NetworkImage(
                                                                "https://placehold.co/16x16",
                                                              ),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 16,
                                                        top: 0,
                                                        child: SizedBox(
                                                          width: 159,
                                                          height: 23,
                                                          child: Text(
                                                            'Near Southern University College\n',
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
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 8,
                                                top: 144,
                                                child: Container(
                                                  width: 118,
                                                  height: 23,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(),
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 16,
                                                        top: 0,
                                                        child: SizedBox(
                                                          width: 102,
                                                          height: 23,
                                                          child: Text(
                                                            '  Posted by Oh Jia Jun',
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
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 0,
                                                        top: 4,
                                                        child: Container(
                                                          width: 16,
                                                          height: 16,
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              image: NetworkImage(
                                                                "https://placehold.co/16x16",
                                                              ),
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 171,
                                                top: 144,
                                                child: Container(
                                                  width: 82,
                                                  height: 23,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(),
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 16,
                                                        top: 0,
                                                        child: SizedBox(
                                                          width: 66,
                                                          height: 23,
                                                          child: Text(
                                                            '  Since 3 hours',
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
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 0,
                                                        top: 4,
                                                        child: Container(
                                                          width: 16,
                                                          height: 16,
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              image: NetworkImage(
                                                                "https://placehold.co/16x16",
                                                              ),
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 23,
                                                child: Container(
                                                  width: 253,
                                                  height: 121,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        "https://placehold.co/253x121",
                                                      ),
                                                      fit: BoxFit.contain,
                                                    ),
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
          TopBar(
            isMiddleSearchBar: false,
            leftIcon: Icons.arrow_back,
            leftIcon_onTap: ()=>{Navigator.pop(context)},

          ),
        ],
      ),
    );
  }
}
