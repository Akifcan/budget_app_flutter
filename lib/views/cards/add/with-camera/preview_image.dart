import 'dart:io';
import 'package:flutter/material.dart';

class PreviewImage extends StatelessWidget {
  final File image;
  const PreviewImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(image: DecorationImage(image: FileImage(image))),
    );
  }
}
