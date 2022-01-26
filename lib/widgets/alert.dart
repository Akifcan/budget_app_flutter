import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final String label;
  final Color background;
  const Alert({Key? key, required this.label, required this.background})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      padding: const EdgeInsets.all(12),
      width: MediaQuery.of(context).size.height,
      child: Text(label,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.white)),
    );
  }
}
