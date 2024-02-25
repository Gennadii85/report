// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../core/variables_holds.dart';

class AddNewTableRowHoldBody extends StatelessWidget {
  final MaterialPageRoute route;
  final Function(String value, List list) updateList;
  final Function(String value) updateValue;
  final Function(String textController) updateEditValue;
  final Function(String name, String value, BuildContext context) saveTableRow;
  final Function resetState;
  final String? name;
  final String value;
  final List valueList;
  final String? editValue;
  const AddNewTableRowHoldBody({
    super.key,
    required this.route,
    required this.updateList,
    required this.updateValue,
    required this.updateEditValue,
    required this.saveTableRow,
    required this.resetState,
    required this.name,
    required this.value,
    required this.valueList,
    this.editValue,
  });

  void goRoute(context) => Navigator.of(context).push(route);

  @override
  Widget build(BuildContext context) {
    final List<String> tableNameList = [];
    List dataList = VarHolds.dataHoldsTable;
    for (var element in dataList) {
      tableNameList.add(element[0]);
    }
    return Column(
      children: [
        Table(
          border: TableBorder.all(color: Colors.black),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(3),
          },
          children: [
            TableRow(
              children: [
                Column(
                  children: [
                    DropdownButton2<String>(
                      hint: const Text('Выберите название строки!'),
                      isExpanded: true,
                      items: tableNameList
                          .map(
                            (elem) => DropdownMenuItem<String>(
                              value: elem,
                              child: Text(
                                elem,
                                softWrap: true,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        updateList(value!, dataList);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(name ?? ''),
                    ),
                  ],
                ),
              ],
            ),
            TableRow(
              children: [
                Column(
                  children: [
                    DropdownButton2<String>(
                      hint: const Text('Выберите значение строки!'),
                      isExpanded: true,
                      items: valueList
                          .map(
                            (elem) => DropdownMenuItem<String>(
                              value: elem,
                              child: Text(
                                elem,
                                softWrap: true,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        updateValue(value!);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onDoubleTap: () => showRedactValue(context, value),
                        child: Text(
                          editValue ?? value,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.shade50,
              ),
              onPressed: () {
                if (name != null) {
                  saveTableRow(
                    name!,
                    editValue ?? value,
                    context,
                  );
                  goRoute(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Сохранять пока нечего'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('SAVE'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.shade50,
              ),
              onPressed: () {
                resetState();
                goRoute(context);
              },
              child: const Text('CANCEL'),
            ),
          ],
        ),
      ],
    );
  }

  Future<dynamic> showRedactValue(
    BuildContext context,
    initValue,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        final TextEditingController controller = TextEditingController(
          text: initValue,
        );
        return AlertDialog(
          content: SingleChildScrollView(
            child: TextField(
              controller: controller,
              maxLines: 30,
              onSubmitted: (value) => controller.text = value,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.shade50,
              ),
              onPressed: () {
                updateEditValue(controller.text);

                Navigator.of(context).pop();
              },
              child: const Text('SAVE'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.shade50,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
          ],
        );
      },
    );
  }
}
