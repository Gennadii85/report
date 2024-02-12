import 'package:flutter/material.dart';

class TableRowUI extends StatelessWidget {
  const TableRowUI({
    super.key,
    required this.name,
    required this.value,
    required this.delete,
  });
  final String name;
  final String value;
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(0.8),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(0.4),
      },
      children: [
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(name),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(value),
            ),
            IconButton(
              onPressed: () => delete(name),
              icon: const Icon(
                Icons.delete_forever_outlined,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
