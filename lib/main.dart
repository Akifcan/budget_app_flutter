import 'package:budget/db/db_provider.dart';
import 'package:budget/style.dart';
import 'package:budget/views/home.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseProvider.instance.database();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', theme: theme, home: const Home());
  }
}
