import 'package:flutter/cupertino.dart';

class NavigatorService {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  // static void openPage(
  //     Widget pageWidget,
  //     bool doReplacement,
  //     ) {
  //   final route = PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => pageWidget,
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       return FadeTransition(opacity: animation, child: child);
  //     },
  //     transitionDuration: Duration(milliseconds: 500),
  //   );
  //
  //   if (doReplacement) {
  //     navigatorKey.currentState?.pushReplacement(route);
  //   } else {
  //     navigatorKey.currentState?.push(route);
  //   }
  // }
  static Future<String> openPage(
      Widget pageWidget,
      bool doReplacement,
      ) async {
    final route = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => pageWidget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: Duration(milliseconds: 500),
    );

    String result="";
    if (doReplacement) {
       result = await navigatorKey.currentState?.pushReplacement(route);
    } else {
      result = await navigatorKey.currentState?.push(route);
    }
    return result;
  }
}
