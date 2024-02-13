part of 'add_new_table_row_cubit.dart';

class AddNewTableRowState {
  AddNewTableRowState({
    required this.valueList,
    required this.value,
    this.name,
    this.editValue,
  });
  String? name;
  String? editValue;
  List<String> valueList = [];
  String value = '';
}
