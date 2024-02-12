import 'package:bloc/bloc.dart';

part 'add_new_table_state.dart';

class AddNewTableCubit extends Cubit<AddNewTableState> {
  AddNewTableCubit() : super(AddNewTableInitial());

  void updateList(String name, List nameList) {
    List<String> valueList = [];
    for (var element in nameList) {
      if (element[0] == name) {
        valueList = element[1];
      }
    }
    emit(
      AddNewTableName(
        valueList: valueList,
        value: valueList.first,
        name: name,
      ),
    );
  }

  void updateValue(value) {
    emit(
      AddNewTableName(
        valueList: state.valueList,
        value: value,
        name: state.name,
      ),
    );
  }

  void updateEditValue(value) {
    emit(
      AddNewTableName(
        valueList: state.valueList,
        value: state.value,
        name: state.name,
        editValue: value,
      ),
    );
  }

  void resetState() {
    emit(
      AddNewTableName(
        valueList: [],
        value: '',
        name: null,
        editValue: null,
      ),
    );
  }
}
