import 'dart:io';

import 'package:budget/db/models/card_images_model.dart';
import 'package:budget/db/models/collection_card.dart';
import 'package:budget/db/tables/credit_card_table.dart';
import 'package:budget/views/cards/add/with-camera/add_with_camera.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';

class CardImages extends StatelessWidget {
  final CollectionCard collectionCard;
  const CardImages({Key? key, required this.collectionCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            collectionCard.name,
          ),
        ),
        body: FutureBuilder<List<CreditCardImages>>(
          future: CreditCardTable.instance
              .cardImagesByCollectionId(collectionCard.id),
          builder: (_, AsyncSnapshot<List<CreditCardImages>> snapshot) {
            if (snapshot.hasData) {
              return PageView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  CreditCardImages image = snapshot.data![index];
                  return Image.file(File(image.path), fit: BoxFit.cover);
                },
              );
            }
            return const Loader();
          },
        ));
  }
}
