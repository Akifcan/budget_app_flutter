import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static push(Widget view) {
    navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => view));
  }

  static pop() {
    navigatorKey.currentState!.pop();
  }

  static pushReplacement(Widget view) {
    navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (_) => view));
  }
}
