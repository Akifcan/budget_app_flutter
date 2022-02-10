import 'package:budget/db/db_provider.dart';
import 'package:budget/db/models/collection_card.dart';
import 'package:budget/views/cards/add/with-camera/add_with_camera.dart';

class CreditCardTable {
  CreditCardTable._privateConstructor();
  static final CreditCardTable _instance =
      CreditCardTable._privateConstructor();
  static CreditCardTable get instance => _instance;

  String collectionTableName = 'credit_card_image_collection';
  String imagesTableName = 'credit_card_images';

  Future<bool> createCollectionAndSaveCardImagePaths(
      String collectionName, List<CardImagesModel> images) async {
    final db = await DatabaseProvider.instance.database();
    await db.rawQuery(
        'INSERT INTO $collectionTableName (name) VALUES(?)', [collectionName]);
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT last_insert_rowid() as collectionId');
    int collectionId = maps[0]['collectionId'];
    for (CardImagesModel image in images) {
      await db.rawQuery(
          'INSERT INTO $imagesTableName (path, name, collection_id) VALUES (?, ?, ?)',
          [image.image!.path, image.title, collectionId]);
    }
    return true;
  }

  Future<List<CollectionCard>> loadCollections() async {
    final db = await DatabaseProvider.instance.database();
    final List<Map<String, dynamic>> maps = await db
        .rawQuery('SELECT * FROM $collectionTableName ORDER BY id DESC');
    return maps
        .map((collection) => CollectionCard.fromJson(collection))
        .toList();
  }

  cardImagesByCollectionId(num collectionId) async {
    final db = await DatabaseProvider.instance.database();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM $imagesTableName where collection_id = ?',
        [collectionId]);
    print(maps);
  }
}
