import 'package:budget/style.dart';
import 'package:budget/views/cards/add/with-camera/add_with_camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PickedImageCard extends StatelessWidget {
  final CardImagesModel cardImagesModel;
  final VoidCallback pickImage;
  final VoidCallback previewImage;
  const PickedImageCard(
      {Key? key,
      required this.cardImagesModel,
      required this.pickImage,
      required this.previewImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(18),
      onTap: () {
        if (cardImagesModel.image != null) {
          previewImage();
        } else {
          pickImage();
        }
      },
      title: Text(cardImagesModel.title),
      subtitle: Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.camera, color: primaryColor),
            label: Text(cardImagesModel.image != null ? "Görüntüle" : "Ekle",
                style: const TextStyle(color: primaryColor))),
      ),
      trailing: cardImagesModel.image != null
          ? const Icon(Icons.done, color: primaryColor)
          : Icon(FontAwesomeIcons.times, color: Colors.red[900]),
    );
  }
}
