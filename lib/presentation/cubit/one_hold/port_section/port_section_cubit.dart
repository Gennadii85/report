import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/model/holds_model.dart';

part 'port_section_state.dart';

class OneHoldPortCubit extends Cubit<OneHoldPortState> {
  final int indexHold;
  final HoldModel holdModel;
  final ImagePicker _picker = ImagePicker();

  OneHoldPortCubit(
    this.indexHold,
    this.holdModel,
  ) : super(
          OneHoldPortState(
            tableMapPort: holdModel.tableMapPort,
            listImagePathPort: holdModel.listImagePathPort,
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
      OneHoldPortState(
        valueList: valueList,
        value: valueList.first,
        name: name,
        tableMapPort: state.tableMapPort,
        listImagePathPort: state.listImagePathPort,
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
      OneHoldPortState(
        valueList: state.valueList,
        value: value,
        name: state.name,
        finishValue: nevList,
        tableMapPort: state.tableMapPort,
        listImagePathPort: state.listImagePathPort,
      ),
    );
  }

  void updateEditValue(String value) {
    emit(
      OneHoldPortState(
        valueList: state.valueList,
        value: state.value,
        name: state.name,
        editValue: value,
        finishValue: state.finishValue,
        tableMapPort: state.tableMapPort,
        listImagePathPort: state.listImagePathPort,
      ),
    );
  }

  void saveTableRow(String name, String value, context) {
    if (name.isNotEmpty || value.isNotEmpty) {
      if (state.tableMapPort.containsKey(name)) {
        state.tableMapPort.remove(name);
        state.tableMapPort.addAll({name: value});
      } else {
        state.tableMapPort.addAll({name: value});
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
      OneHoldPortState(
        tableMapPort: state.tableMapPort,
        listImagePathPort: state.listImagePathPort,
        valueList: [],
        value: '',
      ),
    );
  }

  void deleteTableRow(name) {
    state.tableMapPort.remove(name);
    emit(
      OneHoldPortState(
        tableMapPort: state.tableMapPort,
        listImagePathPort: state.listImagePathPort,
        valueList: [],
        value: '',
      ),
    );
  }

  void resetState() {
    emit(
      OneHoldPortState(
        tableMapPort: state.tableMapPort,
        listImagePathPort: state.listImagePathPort,
        valueList: [],
        value: '',
        name: null,
        editValue: null,
        finishValue: null,
      ),
    );
  }

  Future addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    state.listImagePathPort.add(image.path);
    emit(
      OneHoldPortState(
        tableMapPort: state.tableMapPort,
        listImagePathPort: state.listImagePathPort,
        valueList: state.valueList,
        value: state.value,
      ),
    );
  }

  void deleteImage(int index) {
    state.listImagePathPort.removeAt(index);
    emit(
      OneHoldPortState(
        tableMapPort: state.tableMapPort,
        listImagePathPort: state.listImagePathPort,
        valueList: state.valueList,
        value: state.value,
      ),
    );
  }
}
