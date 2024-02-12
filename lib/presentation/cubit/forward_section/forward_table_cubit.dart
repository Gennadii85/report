import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_invoice_generator_flutter/core/have_variables.dart';
import 'package:pdf_invoice_generator_flutter/core/variables_con_for_mid_aft.dart';
import '../../widgets/message_save.dart';

part 'forward_table_state.dart';

class TableCubitForward extends Cubit<TableStateForward> {
  TableCubitForward()
      : super(
          TableStateForward(
            param1: VarTableForMidAft().coatingForward ??
                VarTableForMidAft.coatingList.first,
            param2: VarTableForMidAft().platingForward ??
                VarTableForMidAft.platingList.first,
            param3: VarTableForMidAft().draftForward ??
                VarTableForMidAft.draftList.first,
          ),
        );

  void updateParameters(param1, param2, param3) {
    emit(
      TableStateForward(
        param1: param1,
        param2: param2,
        param3: param3,
      ),
    );
  }

  void saveForwardSection(
    String boxName,
    context,
    dropdownValue,
  ) async {
    //* boxName = 'Forward Section'
    var box = await Hive.openBox(boxName);
    //* box.put('image', value); сохранение происходит в виджете PickerList на странице ForwardSection
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
