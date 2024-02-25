part of 'port_section_cubit.dart';

class OneHoldPortState {
  Map tableMapPort;
  List<String> listImagePathPort;
  String? name;
  String? editValue;
  List<String> valueList = [];
  String value = '';
  OneHoldPortState({
    required this.tableMapPort,
    required this.listImagePathPort,
    required this.valueList,
    required this.value,
    this.name,
    this.editValue,
  });
}
