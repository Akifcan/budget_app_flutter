import 'package:budget/db/tables/credit_card_table.dart';
import 'package:flutter/material.dart';

class CardImagesList extends StatelessWidget {
  const CardImagesList({Key? key}) : super(key: key);

  loadMyCardImages() {
    CreditCardTable.instance.loadCollections();
  }

  @override
  Widget build(BuildContext context) {
    loadMyCardImages();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kart Resimlerim"),
      ),
    );
  }
}
