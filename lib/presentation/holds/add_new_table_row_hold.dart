import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/widgets/drawer_navigation.dart';
import '../../data/repositories/holds_repositories.dart';
import '../cubit/add_new_table_row/add_new_table_row_cubit.dart';

class AddNewTableRowHold extends StatelessWidget {
  const AddNewTableRowHold({
    super.key,
    required this.boxName,
    required this.dataList,
    required this.route,
    required this.tableMap,
    required this.nameHoldSection,
    required this.indexHold,
    required this.indexSection,
  });
  final Map tableMap;
  final String boxName; //бокс куда сохраняем данные
  final List dataList; //список списков=>index[0]название index[1]значение!
  final MaterialPageRoute route;
  final String nameHoldSection;
  final int indexHold;
  final int indexSection;

  void saveTableRow(
    String name,
    String value,
    Map tableMap,
    int indexHold,
    int indexSection,
  ) =>
      HoldsRepositories().saveTableDada(
        name,
        value,
        nameHoldSection,
        tableMap,
        indexHold,
        indexSection,
      );

  void goRoute(route, context) => Navigator.of(context).push(route);

  @override
  Widget build(BuildContext context) {
    final List<String> tableNameList = [];
    for (var element in dataList) {
      tableNameList.add(element[0]);
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Добавляем таблицу'),
        ),
        drawer: const DrawerNavigation(),
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
              BlocBuilder<AddNewTableRowCubit, AddNewTableRowState>(
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
                                      BlocProvider.of<AddNewTableRowCubit>(
                                        context,
                                      ).updateList(value!, dataList);
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
                                    value: state.value,
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
                                      BlocProvider.of<AddNewTableRowCubit>(
                                        context,
                                      ).updateValue(value);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onDoubleTap: () =>
                                          showRedactValue(context, state),
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
                                  tableMap,
                                  indexHold,
                                  indexSection,
                                );
                                BlocProvider.of<AddNewTableRowCubit>(context)
                                    .resetState();
                                goRoute(route, context);
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
                              BlocProvider.of<AddNewTableRowCubit>(context)
                                  .resetState();
                              goRoute(route, context);
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
    AddNewTableRowState state,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        final TextEditingController controller = TextEditingController(
          text: state.value,
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
                BlocProvider.of<AddNewTableRowCubit>(
                  context,
                ).updateEditValue(
                  controller.text,
                );
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
