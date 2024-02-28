part of 'tank_section_cubit.dart';

class OneHoldTankState {
  Map tableMapTank;
  List<String> listImagePathTank;
  String? name;
  String? editValue;
  List<String> valueList = [];
  String value = '';
  List<String>? finishValue;
  OneHoldTankState({
    required this.tableMapTank,
    required this.listImagePathTank,
    required this.valueList,
    required this.value,
    this.name,
    this.editValue,
    this.finishValue,
  });
}
