// import 'package:bloc/bloc.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// import '../../../core/have_variables.dart';
// import '../../../core/variables_watherdecks.dart';
// import '../../widgets/message_save.dart';

// part 'port_side_state.dart';

// class PortSideCubit extends Cubit<PortSideState> {
//   PortSideCubit()
//       : super(
//           PortSideState(
//             param1: VarPortSide().portSidePlating ??
//                 VarPortSide.portSidePlatingList.first.value,
//             param2: VarPortSide().portSideHandRailing ??
//                 VarPortSide.portSideHandRailingList.first.value,
//             param3: VarPortSide().portSideDeckFittings ??
//                 VarPortSide.portSideDeckFittingsList.first.value,
//           ),
//         );

//   void updateParameters(param1, param2, param3) {
//     emit(
//       PortSideState(
//         param1: param1,
//         param2: param2,
//         param3: param3,
//       ),
//     );
//   }

//   void save(name, valueName, boxName) async {
//     var box = await Hive.openBox(boxName);
//     Map additional = {name: valueName};
//     box.put(VarHave.table, additional);
//   }

//   void savePortSide(String boxName, context) async {
//     //* boxName = 'Port Side'
//     var box = await Hive.openBox(boxName);

//     //* box.put('image', value); сохранение происходит в виджете PickerList на странице Port Side
//     //* ящик там не закрывается
//     box.put('Plating', state.param1);
//     box.put('Hand railing', state.param2);
//     box.put('Deck fittings', state.param3);
//     Massage().saveMassage(context);
//   }
// }
