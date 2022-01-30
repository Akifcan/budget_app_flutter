import 'package:budget/core/navigator_service.dart';
import 'package:budget/db/db_provider.dart';
import 'package:budget/db/provider/category_provider.dart';
import 'package:budget/db/provider/header_provider.dart';
import 'package:budget/style.dart';
import 'package:budget/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HeaderProvider()),
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
    ],
    child: const MyApp(),
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseProvider.instance.database();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        title: 'Flutter Demo',
        theme: theme,
        home: const Splash());
  }
}
