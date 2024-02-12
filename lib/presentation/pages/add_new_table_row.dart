import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_invoice_generator_flutter/presentation/widgets/drawer_navigation.dart';

import '../../core/have_variables.dart';
import '../cubit/add_new_table/add_new_table_cubit.dart';

class AddNewTableRow extends StatelessWidget {
  AddNewTableRow({
    super.key,
    required this.boxName,
    required this.dataList,
    required this.route,
  });

  final String boxName; //бокс куда сохраняем данные  VarHave.boxPortSide;

  final List
      dataList; //лист данных - список списков => index[0]название  index[1]значение!
  final MaterialPageRoute route;

  void saveTableRow(String name, String value) {
    var box = Hive.box(boxName);
    Map maps = box.get(VarHave.table) ?? {};
    maps.addAll({name: value});
    box.put(VarHave.table, maps);
  }

  void goRoute(route, context) => Navigator.of(context).push(route);

  final List<String> tableNameList = [];

  @override
  Widget build(BuildContext context) {
    for (var element in dataList) {
      tableNameList.add(element[0]);
    }
    print(tableNameList);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Добавляем таблицу'),
        ),
        drawer: const DrawerNavigation(),
        body: Column(
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
            BlocBuilder<AddNewTableCubit, AddNewTableState>(
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
                                  // value: state.name ?? tableNameList.first,
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
                                    BlocProvider.of<AddNewTableCubit>(
                                      context,
                                    ).updateList(value!, dataList);
                                  },
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
                                  hint: const Text('Выберите значение строки!'),
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
                                    BlocProvider.of<AddNewTableCubit>(
                                      context,
                                    ).updateValue(value);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onDoubleTap: () => showDialog(
                                      context: context,
                                      builder: (context) {
                                        final TextEditingController controller =
                                            TextEditingController(
                                          text: state.value,
                                        );
                                        return AlertDialog(
                                          content: SingleChildScrollView(
                                            child: TextField(
                                              controller: controller,
                                              maxLines: 30,
                                              onSubmitted: (value) =>
                                                  controller.text = value,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blue.shade50,
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<
                                                    AddNewTableCubit>(
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
                                                backgroundColor:
                                                    Colors.blue.shade50,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('CANCEL'),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
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
                              );
                              BlocProvider.of<AddNewTableCubit>(context)
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
                            BlocProvider.of<AddNewTableCubit>(context)
                                .resetState();
                            Navigator.of(context).pop();
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
    );
  }
}

// class AddNewTableRowCubit extends Cubit<AddNewTableRowState> {
//   AddNewTableRowCubit()
//       : super(
//           AddNewTableRowState(
//             valueList: [],
//             value: '',
//           ),
//         );

//   void updateList(String name, List nameList) {
//     List<String> valueList = [];
//     for (var element in nameList) {
//       if (element[0] == name) {
//         valueList = element[1];
//       }
//     }
//     emit(
//       AddNewTableRowState(
//         valueList: valueList,
//         value: valueList.first,
//         name: name,
//       ),
//     );
//   }

//   void updateValue(value) {
//     emit(
//       AddNewTableRowState(
//         valueList: state.valueList,
//         value: value,
//         name: state.name,
//       ),
//     );
//   }

//   void updateEditValue(value) {
//     emit(
//       AddNewTableRowState(
//         valueList: state.valueList,
//         value: state.value,
//         name: state.name,
//         editValue: value,
//       ),
//     );
//   }

//   void resetState() {
//     emit(
//       AddNewTableRowState(
//         valueList: [],
//         value: '',
//         name: null,
//         editValue: null,
//       ),
//     );
//   }
// }

// class AddNewTableRowState {
//   AddNewTableRowState({
//     required this.valueList,
//     required this.value,
//     this.name,
//     this.editValue,
//   });
//   String? name;
//   String? editValue;
//   List<String> valueList = [];
//   String value = '';
// }
