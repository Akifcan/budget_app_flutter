import 'package:flutter/material.dart';

class BlankContent extends StatelessWidget {
  const BlankContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Image.asset(
          'assets/vectors/blank.png',
          width: 150,
        ),
        const SizedBox(height: 20),
        Text(
          "Burası için henüz bir veri yok",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.w900),
        )
      ],
    ));
  }
}
