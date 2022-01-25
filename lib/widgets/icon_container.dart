import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final String iconName;
  const IconContainer({Key? key, required this.iconName}) : super(key: key);
  final double imageContainerWidth = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      margin: const EdgeInsets.only(top: 5),
      width: imageContainerWidth,
      height: imageContainerWidth,
      child: Image.asset('assets/icons/$iconName.png', fit: BoxFit.contain),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12)),
    );
  }
}
