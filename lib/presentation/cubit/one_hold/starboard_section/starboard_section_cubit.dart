// ignore_for_file: sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/model/holds_model.dart';

part 'starboard_section_state.dart';

class OneHoldStarboardCubit extends Cubit<OneHoldStarboardState> {
  final int indexHold;
  final HoldModel holdModel;
  final ImagePicker _picker = ImagePicker();

  OneHoldStarboardCubit(
    this.indexHold,
    this.holdModel,
  ) : super(
          OneHoldStarboardState(
            tableMapStarboard: holdModel.tableMapStarboard,
            listImagePathStarboard: holdModel.listImagePathStarboard,
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
      OneHoldStarboardState(
        valueList: valueList,
        value: valueList.first,
        name: name,
        tableMapStarboard: state.tableMapStarboard,
        listImagePathStarboard: state.listImagePathStarboard,
      ),
    );
  }

  void updateValue(String value) {
    emit(
      OneHoldStarboardState(
        valueList: state.valueList,
        value: value,
        name: state.name,
        tableMapStarboard: state.tableMapStarboard,
        listImagePathStarboard: state.listImagePathStarboard,
      ),
    );
  }

  void updateEditValue(String value) {
    emit(
      OneHoldStarboardState(
        valueList: state.valueList,
        value: state.value,
        name: state.name,
        editValue: value,
        tableMapStarboard: state.tableMapStarboard,
        listImagePathStarboard: state.listImagePathStarboard,
      ),
    );
  }

  void saveTableRow(String name, String value, context) {
    if (name.isNotEmpty || value.isNotEmpty) {
      if (state.tableMapStarboard.containsKey(name)) {
        state.tableMapStarboard.remove(name);
        state.tableMapStarboard.addAll({name: value});
      } else {
        state.tableMapStarboard.addAll({name: value});
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
      OneHoldStarboardState(
        tableMapStarboard: state.tableMapStarboard,
        listImagePathStarboard: state.listImagePathStarboard,
        valueList: [],
        value: '',
      ),
    );
  }

  void deleteTableRow(name) {
    state.tableMapStarboard.remove(name);
    emit(
      OneHoldStarboardState(
        tableMapStarboard: state.tableMapStarboard,
        listImagePathStarboard: state.listImagePathStarboard,
        valueList: [],
        value: '',
      ),
    );
  }

  void resetState() {
    emit(
      OneHoldStarboardState(
        tableMapStarboard: state.tableMapStarboard,
        listImagePathStarboard: state.listImagePathStarboard,
        valueList: [],
        value: '',
      ),
    );
  }

  Future addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    state.listImagePathStarboard.add(image.path);
    emit(
      OneHoldStarboardState(
        tableMapStarboard: state.tableMapStarboard,
        listImagePathStarboard: state.listImagePathStarboard,
        valueList: state.valueList,
        value: state.value,
      ),
    );
  }

  void deleteImage(int index) {
    state.listImagePathStarboard.removeAt(index);
    emit(
      OneHoldStarboardState(
        tableMapStarboard: state.tableMapStarboard,
        listImagePathStarboard: state.listImagePathStarboard,
        valueList: state.valueList,
        value: state.value,
      ),
    );
  }
}
