import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double radius = 80.0;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Kalan Bakiye",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 10),
          Text(
            "2500₺",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text("Harcanan: 1000₺",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.white)),
          const SizedBox(height: 10),
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.pen, color: Colors.white),
              label:
                  const Text("Düzenle", style: TextStyle(color: Colors.white)))
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
    );
  }
}
