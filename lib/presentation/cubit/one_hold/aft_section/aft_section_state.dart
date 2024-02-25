part of 'aft_section_cubit.dart';

class OneHoldAftState {
  Map tableMapAft;
  List<String> listImagePathAft;
  String? name;
  String? editValue;
  List<String> valueList = [];
  String value = '';
  OneHoldAftState({
    required this.tableMapAft,
    required this.listImagePathAft,
    required this.valueList,
    required this.value,
    this.name,
    this.editValue,
  });
}
