import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_invoice_generator_flutter/core/variables_con_for_mid_aft.dart';
import '../../../core/have_variables.dart';
import '../../widgets/message_save.dart';

part 'middle_table_state.dart';

class TableCubitMiddle extends Cubit<TableStateMiddle> {
  TableCubitMiddle()
      : super(
          TableStateMiddle(
            param1: VarTableForMidAft().coatingMiddle ??
                VarTableForMidAft.coatingList.first,
            param2: VarTableForMidAft().platingMiddle ??
                VarTableForMidAft.platingList.first,
            param3: VarTableForMidAft().draftMiddle ??
                VarTableForMidAft.draftList.first,
          ),
        );

  void updateParameters(param1, param2, param3) {
    emit(
      TableStateMiddle(
        param1: param1,
        param2: param2,
        param3: param3,
      ),
    );
  }

  void saveMiddleSection(
    String boxName,
    context,
    dropdownValue,
  ) async {
    //* boxName = 'Middle Section'
    var box = await Hive.openBox(boxName);

    //* box.put('image', value); сохранение происходит в виджете PickerList на странице MiddleSection
    //* ящик там не закрывается
    box.put('coating', state.param1);
    box.put('plating', state.param2);
    box.put('draft', state.param3);
    box.put('subTitle', dropdownValue);
    Map mapData = {};
    mapData.addAll({
      'coating': state.param1,
      'plating': state.param2,
      'draft': state.param3,
    });
    box.put(VarHave.table, mapData);
    Massage().saveMassage(context);
  }
}
