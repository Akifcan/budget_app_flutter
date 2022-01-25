import 'package:budget/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewRecordCard extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  const NewRecordCard(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.description,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset('assets/icons/$icon.png'),
      title: Text(title),
      subtitle: Text(description),
      trailing: const Icon(FontAwesomeIcons.arrowRight, color: primaryColor),
    );
  }
}
