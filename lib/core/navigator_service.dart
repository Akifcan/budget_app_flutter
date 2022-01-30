import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static push(Widget view) {
    return navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (_) => view));
  }

  static pop() {
    return navigatorKey.currentState!.pop();
  }

  static pushReplacement(Widget view) {
    return navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (_) => view));
  }
}
