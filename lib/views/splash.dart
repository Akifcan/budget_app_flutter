import 'package:budget/core/navigator_service.dart';
import 'package:budget/db/tables/amout_table.dart';
import 'package:budget/views/add/add_amount.dart';
import 'package:budget/views/home.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  amountExistsControl() async {
    if (await AmountTable.instance.isAmountExists()) {
      NavigationService.pushReplacement(const Home());
    } else {
      NavigationService.pushReplacement(const AddAmount());
    }
  }

  @override
  void initState() {
    super.initState();
    amountExistsControl();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Loader(),
    );
  }
}
