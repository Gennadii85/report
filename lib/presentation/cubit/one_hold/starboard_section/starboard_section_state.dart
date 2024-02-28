part of 'starboard_section_cubit.dart';

class OneHoldStarboardState {
  Map tableMapStarboard;
  List<String> listImagePathStarboard;
  String? name;
  String? editValue;
  List<String> valueList = [];
  String value = '';
  List<String>? finishValue;
  OneHoldStarboardState({
    required this.tableMapStarboard,
    required this.listImagePathStarboard,
    required this.valueList,
    required this.value,
    this.name,
    this.editValue,
    this.finishValue,
  });
}
