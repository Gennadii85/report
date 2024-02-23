// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_invoice_generator_flutter/core/variables_holds.dart';
import '../cubit/one_hold/forward_section/one_hold_forward_cubit.dart';

class AddNewTableRowHold extends StatelessWidget {
  final MaterialPageRoute route;
  final Function(String value, List list) updateList;
  final Function(String value) updateValue;
  final Function(String textController) updateEditValue;
  final Function(String name, String value, BuildContext context) saveTableRow;
  final Function resetState;
  const AddNewTableRowHold({
    super.key,
    required this.route,
    required this.updateList,
    required this.updateValue,
    required this.updateEditValue,
    required this.saveTableRow,
    required this.resetState,
  });

  void goRoute(context) => Navigator.of(context).push(route);

  @override
  Widget build(BuildContext context) {
    final List<String> tableNameList = [];
    List dataList = VarHolds.dataHoldsTable;
    for (var element in dataList) {
      tableNameList.add(element[0]);
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Добавляем таблицу'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Выберите нужные параметры и сохраните их !'),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Если нужно редактировать строку просто создайте ее заново и выберите нужное значение!',
                ),
              ),
              const SizedBox(height: 50),
              BlocBuilder<OneHoldForwardCubit, OneHoldForwardState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Table(
                        border: TableBorder.all(color: Colors.black),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
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
                                    hint:
                                        const Text('Выберите название строки!'),
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
                                    child: Text(state.name ?? ''),
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
                                    hint:
                                        const Text('Выберите значение строки!'),
                                    isExpanded: true,
                                    items: state.valueList
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
                                      onDoubleTap: () =>
                                          showRedactValue(context, state.value),
                                      child: Text(
                                        state.editValue ?? state.value,
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
                              if (state.name != null) {
                                saveTableRow(
                                  state.name!,
                                  state.editValue ?? state.value,
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
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
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
                },
              ),
            ],
          ),
        ),
      ),
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
