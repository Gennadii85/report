// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pdf_invoice_generator_flutter/presentation/holds/hold_section_table.dart';

// import '../../data/model/holds_model.dart';
// import '../cubit/one_hold/one_hold_cubit.dart';

// class HoldSection extends StatelessWidget {
//   const HoldSection({
//     super.key,
//     required this.tableMap,
//     required this.holdIndex,
//     required this.nameSection,
//     required this.imageListPath,
//     required this.holdModel,
//   });

//   final HoldModel holdModel;
//   final Map tableMap;
//   final List imageListPath;
//   final int holdIndex;
//   final String nameSection;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(nameSection),
//         ),
//         HoldSectionTable(
//           tableMap: tableMap,
//           holdIndex: holdIndex,
//           holdModel: holdModel,
//         ),
//         //! imageWidget
//       ],
//     );
//   }
// }
