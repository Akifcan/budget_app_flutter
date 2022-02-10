import 'dart:io';

import 'package:budget/db/models/card_images_model.dart';
import 'package:budget/db/models/collection_card.dart';
import 'package:budget/db/tables/credit_card_table.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class CardImages extends StatelessWidget {
  final CollectionCard collectionCard;
  const CardImages({Key? key, required this.collectionCard}) : super(key: key);

  void shareCard() async {
    List<CreditCardImages> paths = await CreditCardTable.instance
        .cardImagesByCollectionId(collectionCard.id);
    Share.shareFiles(paths.map((e) => e.path).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            collectionCard.name,
          ),
          actions: [
            IconButton(
              tooltip: 'Gönder',
              icon: const Icon(FontAwesomeIcons.share),
              onPressed: shareCard,
            )
          ],
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
