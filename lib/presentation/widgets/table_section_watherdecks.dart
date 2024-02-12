import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/have_variables.dart';
import '../pages/add_new_table_row.dart';
import '../widgets/table_row_ui.dart';

class TableSectionWatherdecks extends StatefulWidget {
  const TableSectionWatherdecks({
    super.key,
    required this.maps,
    required this.boxName,
    required this.route,
    required this.dataList,
  });
  final Map maps;
  final String boxName;
  final MaterialPageRoute route;
  final List dataList;

  @override
  State<TableSectionWatherdecks> createState() =>
      _TableSectionWatherdecksState();
}

class _TableSectionWatherdecksState extends State<TableSectionWatherdecks> {
  @override
  Widget build(BuildContext context) {
    List nameList = [];
    List valueList = [];
    widget.maps.forEach((key, value) {
      nameList.add(key);
      valueList.add(value);
    });

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.maps.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) {
            return TableRowUI(
              name: nameList[index],
              value: valueList[index],
              delete: (name) {
                widget.maps.remove(name);
                Hive.box(widget.boxName).put(VarHave.table, widget.maps);
                setState(() {});
              },
            );
          }),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddNewTableRow(
                  boxName: widget.boxName,
                  dataList: widget.dataList,
                  route: widget.route,
                ),
              ),
            );
          },
          child: const Text('Добавить строку'),
        ),
      ],
    );
    //   },
    // );
  }
}
