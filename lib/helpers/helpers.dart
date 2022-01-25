import 'package:budget/core/navigator_service.dart';
import 'package:budget/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showWarningDialog(String title, String description) {
  showDialog(
      context: NavigationService.navigatorKey.currentContext!,
      builder: (_) => AlertDialog(
            title: Text(title),
            content: Text(description),
            actions: [
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: primaryColor),
                  onPressed: () => NavigationService.pop(),
                  icon: const Icon(FontAwesomeIcons.arrowLeft),
                  label: const Text("Geri Dön"))
            ],
          ));
}
