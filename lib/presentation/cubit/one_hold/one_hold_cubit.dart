// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'one_hold_state.dart';

class OneHoldForwardCubit extends Cubit<OneHoldForwardState> {
  int indexHold;

  OneHoldForwardCubit(
    this.indexHold,
  ) : super(
          OneHoldForwardState(
            tableMapForward: {},
            listImagePathForward: [],
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
      OneHoldForwardState(
        valueList: valueList,
        value: valueList.first,
        name: name,
        tableMapForward: state.tableMapForward,
        listImagePathForward: state.listImagePathForward,
      ),
    );
  }

  void updateValue(String value) {
    emit(
      OneHoldForwardState(
        valueList: state.valueList,
        value: value,
        name: state.name,
        tableMapForward: state.tableMapForward,
        listImagePathForward: state.listImagePathForward,
      ),
    );
  }

  void updateEditValue(String value) {
    emit(
      OneHoldForwardState(
        valueList: state.valueList,
        value: state.value,
        name: state.name,
        editValue: value,
        tableMapForward: state.tableMapForward,
        listImagePathForward: state.listImagePathForward,
      ),
    );
  }

  void saveTableRow(String name, String value, context) {
    if (name.isNotEmpty || value.isNotEmpty) {
      if (state.tableMapForward.containsKey(name)) {
        state.tableMapForward.remove(name);
        state.tableMapForward.addAll({name: value});
      } else {
        state.tableMapForward.addAll({name: value});
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Сохранять пока нечего'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    emit(
      OneHoldForwardState(
        tableMapForward: state.tableMapForward,
        listImagePathForward: state.listImagePathForward,
        valueList: [],
        value: '',
      ),
    );
  }

  void deleteTableRow(name) {
    state.tableMapForward.remove(name);
    emit(
      OneHoldForwardState(
        tableMapForward: state.tableMapForward,
        listImagePathForward: state.listImagePathForward,
        valueList: [],
        value: '',
      ),
    );
  }

  void resetState() {
    emit(
      OneHoldForwardState(
        tableMapForward: state.tableMapForward,
        listImagePathForward: state.listImagePathForward,
        valueList: [],
        value: '',
      ),
    );
  }
}
