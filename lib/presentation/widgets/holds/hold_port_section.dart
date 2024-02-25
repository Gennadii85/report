import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/holds_model.dart';
import '../../cubit/one_hold/port_section/port_section_cubit.dart';
import '../all_section/table_row_ui.dart';
import 'add_new_table_row_hold.dart';
import 'hold_image_picker.dart';
import 'one_hold.dart';

//! Port transverse bulkhead

class HoldPortSection extends StatelessWidget {
  const HoldPortSection({
    super.key,
    required this.holdModel,
    required this.holdIndex,
  });

  final HoldModel holdModel;
  final int holdIndex;

  @override
  Widget build(BuildContext context) {
    OneHoldPortCubit cubit = BlocProvider.of<OneHoldPortCubit>(context);
    return BlocBuilder<OneHoldPortCubit, OneHoldPortState>(
      builder: (context, state) {
        List nameList = [];
        List valueList = [];
        state.tableMapPort.forEach((key, value) {
          nameList.add(key);
          valueList.add(value);
        });
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //! Table
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(holdModel.namePort),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.tableMapPort.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return TableRowUI(
                    name: nameList[index],
                    value: valueList[index],
                    delete: (name) {
                      BlocProvider.of<OneHoldPortCubit>(context)
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
                      builder: (context) => AddNewTableRowPortHold(
                        route: MaterialPageRoute(
                          builder: (context) => OneHold(
                            holdIndex: holdIndex,
                            holdModel: holdModel,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Добавить строку'),
              ),
              const SizedBox(height: 20),
              //! Image
              HoldPickerList(
                imagesPath: state.listImagePathPort,
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
