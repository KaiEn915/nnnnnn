import 'package:flutter/cupertino.dart';

class NavigatorService {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static Future<String?> openPage(
      Widget pageWidget,
      bool doReplacement,
      ) async {
    Route<Object> route = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => pageWidget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: Duration(milliseconds: 500),
    );

    Object? result;
    if (doReplacement) {
      result = await navigatorKey.currentState?.pushReplacement(route);
    } else {
      result = await navigatorKey.currentState?.push(route);
    }

    // Cast result to String?, or change to another type if needed
    return result as String?;
  }
}
