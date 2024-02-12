import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/have_variables.dart';
import '../pages/add_new_table_row.dart';
import '../widgets/table_row_ui.dart';

class TableSectionWatherdecks extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // return
    //  BlocBuilder<AddNewTableRowCubit, AddNewTableRowState>(
    // builder: (context, state) {
    // Map maps = maps;
    List nameList = [];
    List valueList = [];
    maps.forEach((key, value) {
      nameList.add(key);
      valueList.add(value);
    });

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: maps.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) {
            return TableRowUI(
              name: nameList[index],
              value: valueList[index],
              delete: (name) {
                maps.remove(name);
                Hive.box(boxName).put(VarHave.table, maps);
                // BlocProvider.of<AddNewTableRowCubit>(
                //   context,
                // ).resetState();
                // setState(() {});
              },
            );
          }),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddNewTableRow(
                  boxName: boxName,
                  dataList: dataList,
                  route: route,
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
