import 'package:budget/db/models/collection_card.dart';
import 'package:budget/db/tables/credit_card_table.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';

class CardCollectionList extends StatelessWidget {
  const CardCollectionList({Key? key}) : super(key: key);

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
      body: FutureBuilder<List<CollectionCard>>(
        future: CreditCardTable.instance.loadCollections(),
        builder: (_, AsyncSnapshot<List<CollectionCard>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                CollectionCard collectionCard = snapshot.data![index];
                return ListTile(
                  title: Text(collectionCard.name),
                  subtitle: Text("${index + 1}"),
                );
              },
            );
          } else {
            return const Loader();
          }
        },
      ),
    );
  }
}
