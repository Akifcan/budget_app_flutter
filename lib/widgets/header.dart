import 'package:budget/core/navigator_service.dart';
import 'package:budget/db/provider/header_provider.dart';
import 'package:budget/views/add/add_amount.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double radius = 80.0;

    return Consumer<HeaderProvider>(builder: (_, model, __) {
      return !model.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Kalan Bakiye",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${model.headerInformations.amount}₺",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                      "Belirlediğiniz Tutar: ${model.headerInformations.current}₺",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Colors.white)),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  TextButton.icon(
                      onPressed: () =>
                          NavigationService.push(const AddAmount()),
                      icon:
                          const Icon(FontAwesomeIcons.pen, color: Colors.white),
                      label: const Text("Düzenle / Görüntüle",
                          style: TextStyle(color: Colors.white)))
                ],
              ),
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 20,
                      offset: Offset(0, 8), // Shadow position
                    ),
                  ],
                  color: Color(0xff006994),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  )),
            )
          : const Padding(
              padding: EdgeInsets.only(top: 50, bottom: 20),
              child: Loader(),
            );
    });
  }
}
