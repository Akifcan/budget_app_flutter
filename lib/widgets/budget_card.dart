import 'package:flutter/material.dart';

class BudgetCard extends StatelessWidget {
  final String title;
  final num amount;
  final Color backgroundColor;
  final Color textColor;
  const BudgetCard(
      {Key? key,
      required this.title,
      required this.amount,
      required this.backgroundColor,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(2, 8), // Shadow position
          ),
        ], color: backgroundColor, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.w300, color: textColor),
            ),
            Text(
              "$amount₺",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: textColor),
            )
          ],
        ),
      ),
    );
  }
}
