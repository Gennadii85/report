part of 'add_new_table_cubit.dart';

class AddNewTableState {}

class AddNewTableInitial extends AddNewTableState {
  List<String> valueList = [];
  String value = '';
}

class AddNewTableName extends AddNewTableState {
  AddNewTableName({
    required this.valueList,
    required this.value,
    required this.name,
    required this.editValue,
  });
  String name;
  String editValue;
  List<String> valueList;
  String value;
}
