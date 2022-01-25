import 'package:flutter/material.dart';

const primaryColor = Color(0xff006994);
const body = Color(0xffdedede);

ThemeData theme = ThemeData(
    inputDecorationTheme: const InputDecorationTheme(filled: true),
    appBarTheme:
        const AppBarTheme(backgroundColor: primaryColor, centerTitle: true),
    scaffoldBackgroundColor: body,
    primaryColor: primaryColor);
