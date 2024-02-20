// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../core/have_variables.dart';
import '../../data/model/holds_model.dart';
import '../widgets/table_row_ui.dart';
import 'add_new_table_row_hold.dart';

class HoldSectionTable extends StatefulWidget {
  const HoldSectionTable({
    super.key,
    required this.dataList,
    required this.holdNumber,
    required this.nameSection,
    required this.route,
    required this.model,
    required this.indexHold,
    required this.indexSection,
  });
  final List dataList;
  final int holdNumber;
  final String nameSection;
  final MaterialPageRoute route;
  final HoldSectionModel model;
  final int indexHold;
  final int indexSection;

  @override
  State<HoldSectionTable> createState() => _HoldSectionTableState();
}

class _HoldSectionTableState extends State<HoldSectionTable> {
  @override
  Widget build(BuildContext context) {
    Map tableMap = widget.model.tableMap;
    List nameList = [];
    List valueList = [];
    tableMap.forEach((key, value) {
      nameList.add(key);
      valueList.add(value);
    });

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.nameSection),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: tableMap.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) {
            return TableRowUI(
              name: nameList[index],
              value: valueList[index],
              delete: (name) {
                tableMap.remove(name);
                setState(() {});
              },
            );
          }),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddNewTableRowHold(
                  boxName: VarHave.boxHolds,
                  dataList: widget.dataList,
                  route: widget.route,
                  tableMap: widget.model.tableMap,
                  nameHoldSection: widget.nameSection,
                  indexHold: widget.indexHold,
                  indexSection: widget.indexSection,
                ),
              ),
            );
          },
          child: const Text('Добавить строку'),
        ),
      ],
    );
  }
}
