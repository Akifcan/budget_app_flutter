import 'package:budget/db/models/graphics/wallet_sum.dart';
import 'package:budget/db/tables/wallet_table.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';

class GroupCategories extends StatelessWidget {
  const GroupCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WalletGroup>>(
      future: WalletTable.instance.groupExpenses(),
      builder: (_, AsyncSnapshot<List<WalletGroup>> snapshot) {
        if (!snapshot.hasData) {
          return const Loader();
        }
        return DataTable(
            columns: const [
              DataColumn(
                  label: Text('Kategori',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Harcamanız',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ],
            rows: snapshot.data!
                .map((e) => DataRow(cells: [
                      DataCell(Text(e.label)),
                      DataCell(Text('${e.value}₺')),
                    ]))
                .toList());
      },
    );
  }
}
