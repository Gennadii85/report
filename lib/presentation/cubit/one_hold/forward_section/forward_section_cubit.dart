import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_invoice_generator_flutter/data/model/holds_model.dart';

part 'forward_section_state.dart';

class OneHoldForwardCubit extends Cubit<OneHoldForwardState> {
  final int indexHold;
  final HoldModel holdModel;
  final ImagePicker _picker = ImagePicker();

  OneHoldForwardCubit(
    this.indexHold,
    this.holdModel,
  ) : super(
          OneHoldForwardState(
            tableMapForward: holdModel.tableMapForward,
            listImagePathForward: holdModel.listImagePathForward,
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

  Future addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    state.listImagePathForward.add(image.path);
    emit(
      OneHoldForwardState(
        tableMapForward: state.tableMapForward,
        listImagePathForward: state.listImagePathForward,
        valueList: state.valueList,
        value: state.value,
      ),
    );
  }

  void deleteImage(int index) {
    state.listImagePathForward.removeAt(index);
    emit(
      OneHoldForwardState(
        tableMapForward: state.tableMapForward,
        listImagePathForward: state.listImagePathForward,
        valueList: state.valueList,
        value: state.value,
      ),
    );
  }
}
