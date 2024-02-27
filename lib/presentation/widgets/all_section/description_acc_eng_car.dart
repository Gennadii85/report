import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../pages/add_new_table_row.dart';

class DescriptionAccEngCar extends StatelessWidget {
  const DescriptionAccEngCar({
    super.key,
    required this.boxName,
    required this.dataList,
    required this.route,
    required this.keyBoxValue,
  });
  final String boxName;
  final List<List> dataList;
  final MaterialPageRoute route;
  final String keyBoxValue;

  @override
  Widget build(BuildContext context) {
    final Map titleMap = Hive.box(boxName).get(keyBoxValue) ?? {};
    String title = '';
    if (titleMap.isEmpty) {
      title = '';
    } else {
      title = titleMap.entries.first.value.toString();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddNewTableRow(
                  boxName: boxName,
                  dataList: dataList,
                  route: route,
                  keyBoxValue: keyBoxValue,
                  isNoWeather: true,
                ),
              ),
            );
          },
          child: const Text('Выбрать описание'),
        ),
      ],
    );
  }
}
