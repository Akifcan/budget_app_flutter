import 'dart:io';

import 'package:budget/core/navigator_service.dart';
import 'package:budget/db/tables/credit_card_table.dart';
import 'package:budget/style.dart';
import 'package:budget/views/cards/add/with-camera/preview_image.dart';
import 'package:budget/widgets/loader.dart';
import 'package:budget/widgets/picked_image_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CardImagesModel {
  String title;
  XFile? image;

  CardImagesModel({required this.title, required this.image});
}

class AddWithCamera extends StatefulWidget {
  const AddWithCamera({Key? key}) : super(key: key);

  @override
  State<AddWithCamera> createState() => _AddWithCameraState();
}

class _AddWithCameraState extends State<AddWithCamera> {
  final List<CardImagesModel> images = [
    CardImagesModel(title: "Kartınızın Ön Yüzü", image: null),
    CardImagesModel(title: "Kartınızın Arka Yüzü", image: null),
  ];

  final ImagePicker picker = ImagePicker();
  bool isLoading = false;

  bool get areImagesSelected =>
      images.where((element) => element.image == null).isEmpty;

  void pickImage(int index) async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        images[index].image = photo;
      });
    }
  }

  void previewImage(int index) {
    NavigationService.push(
        PreviewImage(image: File(images[index].image!.path)));
  }

  void collectionNameDialog() {
    TextEditingController collectionName = TextEditingController();
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Başlığınız"),
              content: TextField(
                controller: collectionName,
                decoration: InputDecoration(
                    helperText:
                        '${images.length} adet resim ile kayıt ediyorsunuz.',
                    labelText: 'Başlığınız',
                    prefixIcon: const Icon(Icons.title, color: primaryColor)),
              ),
              actions: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: primaryColor),
                  icon: const Icon(Icons.arrow_left),
                  onPressed: () {
                    NavigationService.pop();
                  },
                  label: const Text("Geri Dön"),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.green[700]),
                  icon: const Icon(Icons.done),
                  onPressed: () {
                    if (collectionName.text.isNotEmpty) {
                      saveImages(collectionName.text);
                    }
                  },
                  label: const Text("Kayıt Et"),
                ),
              ],
            ));
  }

  saveImages(String collectionName) async {
    await CreditCardTable.instance
        .createCollectionAndSaveCardImagePaths(collectionName, images);
    Navigator.of(context)
      ..pop()
      ..pop()
      ..pop();
  }

  @override
  Widget build(BuildContext context) {
    areImagesSelected;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kartınızın Resimleri"),
      ),
      bottomNavigationBar: areImagesSelected
          ? InkWell(
              onTap: collectionNameDialog,
              child: Container(
                color: primaryColor,
                height: MediaQuery.of(context).size.height * .1,
                child: Center(
                    child: Text(
                  "Kartınızı Ekleyin",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                )),
              ),
            )
          : const SizedBox.shrink(),
      body: !isLoading
          ? Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: images.length,
                  itemBuilder: (_, index) {
                    return PickedImageCard(
                        pickImage: () => pickImage(index),
                        previewImage: () => previewImage(index),
                        cardImagesModel: images[index]);
                  },
                )
              ],
            )
          : const Loader(),
    );
  }
}
