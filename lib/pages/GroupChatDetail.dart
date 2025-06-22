import 'package:flutter/material.dart';
import 'package:gan/widgets/TopBar.dart';

class GroupChatDetail extends StatefulWidget {
  const GroupChatDetail({super.key});

  @override
  State<GroupChatDetail> createState() => _GroupChatDetailWidgetState();
}

class _GroupChatDetailWidgetState extends State<GroupChatDetail> {

    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          Container(
            width: MediaQuery
                .sizeOf(context)
                .width,
            height: MediaQuery
                .sizeOf(context)
                .height,
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
                  left: 24,
                  top: 242,
                  child: Container(
                    width: 326,
                    height: 30,
                    child: Stack(
                      children: [
                          SizedBox(
                            width: 326,
                            height: 30,
                            child: Text(
                              'GROUP CHAT',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'IBM Plex Sans',
                                fontWeight: FontWeight.w700,
                                height: 1,
                                letterSpacing: 3,
                                shadows: [
                                  Shadow(offset: Offset(0, 4),
                                      blurRadius: 4,
                                      color: Color(0xFF000000).withOpacity(
                                          0.25))
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                //头像
                Positioned(
                  left: 145,
                  top: 150,
                  child: Container(
                    width: 125,
                    height: 125,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/cat.png"),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
                //里面的members
                Positioned(
                  top: 460,
                  child: Container(
                    width: 390,
                    height: 250,
                    margin: const EdgeInsets.only(left: 10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD5EDF8),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                      child: SingleChildScrollView(
                         child: Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          spacing: 14,
                          runSpacing: 10,
                          children: [
                            Container(
                              width: 390,
                              height: 30,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 10,
                                    child: SizedBox(
                                      width: 390,
                                      height: 200,
                                      child: Text(
                                        'MEMBERS',
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
                                              color: Color(0xFF000000).withOpacity(0.25),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //到时members 放在里
                            Container(
                              width: 137,
                              height: 51,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 8.50,
                                    top: 7,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage("https://placehold.co/40x40"),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 48.50,
                                    top: 5,
                                    child: SizedBox(
                                      width: 83,
                                      height: 44,
                                      child: Text(
                                        'Hue Zhi En',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          height: 1.40,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 36.50,
                                    top: 35,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage("https://placehold.co/12x12"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
                //delete group chat
                Positioned(
                  left: 80,
                  top: 750,
                  child: Container(
                    width: 250,
                    height: 60,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF730000),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Delete Group Chat',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
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
                  left: 10,
                  top: 320,
                  child: Container(
                    width: 390,
                    height: 100,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFE5E5CF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: 3,
                      runSpacing: 3,
                      children: [
                        Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/17x17"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: Text(
                            'About this group:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.40,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 326,
                          child: Text(
                            'Aimed to facilitate the process of finding my missing pet named Chan Wei Er.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Jura',
                              fontWeight: FontWeight.w600,
                              height: 1.40,
                            ),
                          ),
                        ),
                        Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/17x17"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 259,
                          child: Text(
                            'This group was created 7 days ago',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Jura',
                              fontWeight: FontWeight.w300,
                              height: 1.40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TopBar(
                  isMiddleSearchBar: false,
                  header: "ABOUT",
                  leftIcon: Icons.arrow_back,
                  leftIcon_onTap: () =>
                  {
                    Navigator.pushNamed(context, "/GroupChatRoom"),
                  },
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
