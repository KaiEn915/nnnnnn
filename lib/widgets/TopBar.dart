import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.isMiddleSearchBar,
    this.header = "",
    this.leftIcon,
    this.leftIcon_onTap,
    this.rightIcon,
    this.rightIcon_onTap,
    this.searchBarController,
  });

  final bool isMiddleSearchBar;
  final String header;
  final IconData? leftIcon;
  final VoidCallback? leftIcon_onTap;
  final IconData? rightIcon;
  final VoidCallback? rightIcon_onTap;
  final TextEditingController? searchBarController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Container(
        //search box table
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(vertical: 8),
        // margin: const EdgeInsets.symmetric(horizontal: 15),
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
              offset: Offset(0, 0),
              spreadRadius: 1,
            ),
          ],
        ),

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 10,
            children: [
              leftIcon != null
                  ? GestureDetector(
                      onTap: leftIcon_onTap,
                      child: Container(
                        width: 37,
                        height: 37,
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
                        child: Icon(leftIcon),
                      ),
                    )
                  : SizedBox(width: 37, height: 37),
              isMiddleSearchBar
                  ? Container(
                      width: 244,
                      padding: const EdgeInsets.symmetric(vertical: 10),
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 5,
                        children: [
                          Container(
                            width: 180,
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
                            child: TextField(
                              controller: searchBarController,
                              decoration: InputDecoration(
                                hintText: 'Search post...',
                              ),

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: const Color(0xFF828282),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            width: 31,
                            child: Icon(Icons.search),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: 244,
                      padding: const EdgeInsets.symmetric(vertical: 10),
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
                      child: Container(
                        child: Text(
                          header,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'IBM Plex Sans',
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 3.30,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 4),
                                blurRadius: 4,
                                color: Color(0xFF000000).withAlpha(64),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              rightIcon != null
                  ? GestureDetector(
                      onTap: rightIcon_onTap,
                      child: Container(
                        width: 37,
                        height: 37,
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
                        child: Icon(rightIcon),
                      ),
                    )
                  : SizedBox(width: 37, height: 37),
            ],
          ),
        ),
      ),
    );
  }
}
