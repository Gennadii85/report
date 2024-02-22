// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pdf_invoice_generator_flutter/data/repositories/holds_repositories.dart';
// import '../../data/model/holds_model.dart';
// import '../widgets/table_row_ui.dart';
// import 'add_new_table_row_hold.dart';

// class HoldSectionTable extends StatefulWidget {
//   const HoldSectionTable({
//     super.key,
//     required this.holdIndex,
//     required this.tableMap,
//     required this.holdModel,
//   });
//   final HoldModel holdModel;
//   final int holdIndex;
//   final Map tableMap;

//   @override
//   State<HoldSectionTable> createState() => _HoldSectionTableState();
// }

// class _HoldSectionTableState extends State<HoldSectionTable> {
//   @override
//   Widget build(BuildContext context) {
//     Map tableMap = widget.tableMap;
//     List nameList = [];
//     List valueList = [];
//     tableMap.forEach((key, value) {
//       nameList.add(key);
//       valueList.add(value);
//     });

//     return Column(
//       children: [
//         ListView.builder(
//           shrinkWrap: true,
//           itemCount: tableMap.length,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: ((context, index) {
//             return TableRowUI(
//               name: nameList[index],
//               value: valueList[index],
//               delete: (name) {
//                 HoldsRepositories().deleteTableRow(name);
//                 setState(() {});
//               },
//             );
//           }),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => AddNewTableRowHold(
//                   tableMap: tableMap,
//                   indexHold: widget.holdIndex,
//                   holdModel: widget.holdModel,
//                 ),
//               ),
//             );
//           },
//           child: const Text('Добавить строку'),
//         ),
//       ],
//     );
//   }
// }
