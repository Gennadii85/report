import 'package:bloc/bloc.dart';

part 'add_new_table_row_state.dart';

class AddNewTableRowCubit extends Cubit<AddNewTableRowState> {
  AddNewTableRowCubit()
      : super(
          AddNewTableRowState(
            valueList: [],
            value: '',
          ),
        );

  void updateList(String name, List nameList) {
    List<String> valueList = [];
    for (var element in nameList) {
      if (element[0] == name) {
        valueList = element[1];
      }
    }
    emit(
      AddNewTableRowState(
        valueList: valueList,
        value: '',
        name: name,
      ),
    );
  }

  void updateValue(int index) {
    List<String> nevList = state.finishValue ?? [];
    String value = '';
    if (nevList.contains(state.valueList[index])) {
      return;
    } else {
      nevList.add(state.valueList[index]);
      value = nevList.join('\n \n');
    }

    emit(
      AddNewTableRowState(
        valueList: state.valueList,
        value: value,
        name: state.name,
        finishValue: nevList,
      ),
    );
  }

  void updateEditValue(value) {
    emit(
      AddNewTableRowState(
        valueList: state.valueList,
        value: state.value,
        name: state.name,
        editValue: value,
        finishValue: state.finishValue,
      ),
    );
  }

  void resetState() {
    emit(
      AddNewTableRowState(
        valueList: [],
        value: '',
        name: null,
        editValue: null,
        finishValue: null,
      ),
    );
  }
}
