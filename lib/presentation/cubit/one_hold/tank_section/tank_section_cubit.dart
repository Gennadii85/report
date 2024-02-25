import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/model/holds_model.dart';

part 'tank_section_state.dart';

class OneHoldTankCubit extends Cubit<OneHoldTankState> {
  final int indexHold;
  final HoldModel holdModel;
  final ImagePicker _picker = ImagePicker();

  OneHoldTankCubit(
    this.indexHold,
    this.holdModel,
  ) : super(
          OneHoldTankState(
            tableMapTank: holdModel.tableMapTank,
            listImagePathTank: holdModel.listImagePathTank,
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
      OneHoldTankState(
        valueList: valueList,
        value: valueList.first,
        name: name,
        tableMapTank: state.tableMapTank,
        listImagePathTank: state.listImagePathTank,
      ),
    );
  }

  void updateValue(String value) {
    emit(
      OneHoldTankState(
        valueList: state.valueList,
        value: value,
        name: state.name,
        tableMapTank: state.tableMapTank,
        listImagePathTank: state.listImagePathTank,
      ),
    );
  }

  void updateEditValue(String value) {
    emit(
      OneHoldTankState(
        valueList: state.valueList,
        value: state.value,
        name: state.name,
        editValue: value,
        tableMapTank: state.tableMapTank,
        listImagePathTank: state.listImagePathTank,
      ),
    );
  }

  void saveTableRow(String name, String value, context) {
    if (name.isNotEmpty || value.isNotEmpty) {
      if (state.tableMapTank.containsKey(name)) {
        state.tableMapTank.remove(name);
        state.tableMapTank.addAll({name: value});
      } else {
        state.tableMapTank.addAll({name: value});
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
      OneHoldTankState(
        tableMapTank: state.tableMapTank,
        listImagePathTank: state.listImagePathTank,
        valueList: [],
        value: '',
      ),
    );
  }

  void deleteTableRow(name) {
    state.tableMapTank.remove(name);
    emit(
      OneHoldTankState(
        tableMapTank: state.tableMapTank,
        listImagePathTank: state.listImagePathTank,
        valueList: [],
        value: '',
      ),
    );
  }

  void resetState() {
    emit(
      OneHoldTankState(
        tableMapTank: state.tableMapTank,
        listImagePathTank: state.listImagePathTank,
        valueList: [],
        value: '',
      ),
    );
  }

  Future addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    state.listImagePathTank.add(image.path);
    emit(
      OneHoldTankState(
        tableMapTank: state.tableMapTank,
        listImagePathTank: state.listImagePathTank,
        valueList: state.valueList,
        value: state.value,
      ),
    );
  }

  void deleteImage(int index) {
    state.listImagePathTank.removeAt(index);
    emit(
      OneHoldTankState(
        tableMapTank: state.tableMapTank,
        listImagePathTank: state.listImagePathTank,
        valueList: state.valueList,
        value: state.value,
      ),
    );
  }
}
