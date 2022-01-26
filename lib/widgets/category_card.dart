import 'package:budget/db/models/category.dart';
import 'package:budget/widgets/icon_container.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      color: const Color(0xffEbf6f7),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            IconContainer(iconName: category.icon.replaceAll('.png', '')),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category.name,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: const Color(0xff0F0E0E),
                        fontWeight: FontWeight.w600)),
                Text("Harcanan: 100₺ Kazanç: 200₺",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: const Color(0xff1F1D36))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
