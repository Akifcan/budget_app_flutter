import 'package:budget/core/navigator_service.dart';
import 'package:budget/style.dart';
import 'package:budget/views/cards/add/with-camera/add_with_camera.dart';
import 'package:budget/views/cards/list/card_images_list.dart';
import 'package:budget/widgets/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyCards extends StatelessWidget {
  const MyCards({Key? key}) : super(key: key);

  newCardOptionDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Kayıt Türü Seçin"),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.green[700]),
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.creditCard),
                      label: const Text("Kayıt Edin")),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: primaryColor),
                      onPressed: () => NavigationService.push(AddWithCamera()),
                      icon: const Icon(FontAwesomeIcons.camera),
                      label: const Text("Fotoğrafını Çekin")),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () => NavigationService.pop(),
                    child: const Text("Geri Dön"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kredi Kartlarım"),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () => NavigationService.push(const CardImagesList()),
            leading: const IconContainer(
              iconName: 'credit-card',
            ),
            title: const Text("Kart Resimlerim"),
            subtitle: const Text("Kayıt Ettiğiniz Kart Resimleri"),
          ),
          ListTile(
            onTap: () {},
            leading: const IconContainer(
              iconName: 'credit-card',
            ),
            title: const Text("Kart Kayıtlarım"),
            subtitle: const Text("Tüm Kayıt Bilgilerim"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Yeni Kart Ekleyin',
        onPressed: () {
          newCardOptionDialog(context);
        },
        child: const Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
