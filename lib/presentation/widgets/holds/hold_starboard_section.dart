import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/holds_model.dart';
import '../../cubit/one_hold/starboard_section/starboard_section_cubit.dart';
import '../all_section/table_row_ui.dart';
import 'add_new_table_row_hold.dart';
import 'hold_image_picker.dart';
import 'one_hold.dart';

//! Starboard transverse bulkhead

class HoldStarboardSection extends StatelessWidget {
  const HoldStarboardSection({
    super.key,
    required this.holdModel,
    required this.holdIndex,
  });

  final HoldModel holdModel;
  final int holdIndex;

  @override
  Widget build(BuildContext context) {
    OneHoldStarboardCubit cubit =
        BlocProvider.of<OneHoldStarboardCubit>(context);
    return BlocBuilder<OneHoldStarboardCubit, OneHoldStarboardState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //! Table
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(holdModel.nameStarboard),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.tableMapStarboard.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  List nameList = [];
                  List valueList = [];
                  state.tableMapStarboard.forEach((key, value) {
                    nameList.add(key);
                    valueList.add(value);
                  });
                  return TableRowUI(
                    name: nameList[index],
                    value: valueList[index],
                    delete: (name) {
                      BlocProvider.of<OneHoldStarboardCubit>(context)
                          .deleteTableRow(name);
                    },
                  );
                }),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddNewTableRowHold(
                        route: MaterialPageRoute(
                          builder: (context) => OneHold(
                            holdIndex: holdIndex,
                            holdModel: holdModel,
                          ),
                        ),
                        updateList: (value, dataList) =>
                            cubit.updateList(value, dataList),
                        updateValue: (value) => cubit.updateValue(value),
                        saveTableRow: (name, value, context) =>
                            cubit.saveTableRow(name, value, context),
                        resetState: () => cubit.resetState(),
                        updateEditValue: (textController) =>
                            cubit.updateEditValue(textController),
                      ),
                    ),
                  );
                },
                child: const Text('Добавить строку'),
              ),
              const SizedBox(height: 20),
              //! Image
              HoldPickerList(
                imagesPath: state.listImagePathStarboard,
                deleteImage: (index) => cubit.deleteImage(index),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => cubit.addImage(),
                child: const Text('Добавить фото'),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
