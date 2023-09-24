import 'package:flutter/material.dart';

class HistoryTable extends StatelessWidget {
  const HistoryTable({super.key});

  @override
  Widget build(context) {
    return DataTable(
      sortAscending: true,
      sortColumnIndex: 1,
      showBottomBorder: false,
      columns: const [
        DataColumn(label: Text('ID'), numeric: true),
        DataColumn(label: Text('Lottery Number')),
        DataColumn(label: Text('Prize')),
      ],
      rows: const [
        DataRow(
          cells: [
            DataCell(Text('1', textAlign: TextAlign.right)),
            DataCell(Text(
              'Fancy Product',
            )),
            DataCell(Text(r'$ 199.99', textAlign: TextAlign.right))
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('2', textAlign: TextAlign.right)),
            DataCell(Text('Another Product')),
            DataCell(Text(r'$ 79.00', textAlign: TextAlign.right))
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('3', textAlign: TextAlign.right)),
            DataCell(Text('Really Cool Stuff')),
            DataCell(Text(r'$ 9.99', textAlign: TextAlign.right))
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('4', textAlign: TextAlign.right)),
            DataCell(Text(
              'Last Product goes here',
            )),
            DataCell(Text(r'$ 19.99', textAlign: TextAlign.right))
          ],
        ),
      ],
    );
  }
}
