import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/model/holds_model.dart';

part 'aft_section_state.dart';

class OneHoldAftCubit extends Cubit<OneHoldAftState> {
  final int indexHold;
  final HoldModel holdModel;
  final ImagePicker _picker = ImagePicker();

  OneHoldAftCubit(
    this.indexHold,
    this.holdModel,
  ) : super(
          OneHoldAftState(
            tableMapAft: holdModel.tableMapAft,
            listImagePathAft: holdModel.listImagePathAft,
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
      OneHoldAftState(
        valueList: valueList,
        value: valueList.first,
        name: name,
        tableMapAft: state.tableMapAft,
        listImagePathAft: state.listImagePathAft,
      ),
    );
  }

  void updateValue(String value) {
    emit(
      OneHoldAftState(
        valueList: state.valueList,
        value: value,
        name: state.name,
        tableMapAft: state.tableMapAft,
        listImagePathAft: state.listImagePathAft,
      ),
    );
  }

  void updateEditValue(String value) {
    emit(
      OneHoldAftState(
        valueList: state.valueList,
        value: state.value,
        name: state.name,
        editValue: value,
        tableMapAft: state.tableMapAft,
        listImagePathAft: state.listImagePathAft,
      ),
    );
  }

  void saveTableRow(String name, String value, context) {
    if (name.isNotEmpty || value.isNotEmpty) {
      if (state.tableMapAft.containsKey(name)) {
        state.tableMapAft.remove(name);
        state.tableMapAft.addAll({name: value});
      } else {
        state.tableMapAft.addAll({name: value});
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
      OneHoldAftState(
        tableMapAft: state.tableMapAft,
        listImagePathAft: state.listImagePathAft,
        valueList: [],
        value: '',
      ),
    );
  }

  void deleteTableRow(name) {
    state.tableMapAft.remove(name);
    emit(
      OneHoldAftState(
        tableMapAft: state.tableMapAft,
        listImagePathAft: state.listImagePathAft,
        valueList: [],
        value: '',
      ),
    );
  }

  void resetState() {
    emit(
      OneHoldAftState(
        tableMapAft: state.tableMapAft,
        listImagePathAft: state.listImagePathAft,
        valueList: [],
        value: '',
      ),
    );
  }

  Future addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    state.listImagePathAft.add(image.path);
    emit(
      OneHoldAftState(
        tableMapAft: state.tableMapAft,
        listImagePathAft: state.listImagePathAft,
        valueList: state.valueList,
        value: state.value,
      ),
    );
  }

  void deleteImage(int index) {
    state.listImagePathAft.removeAt(index);
    emit(
      OneHoldAftState(
        tableMapAft: state.tableMapAft,
        listImagePathAft: state.listImagePathAft,
        valueList: state.valueList,
        value: state.value,
      ),
    );
  }
}
