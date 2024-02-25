import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/holds_model.dart';
import '../../cubit/one_hold/tank_section/tank_section_cubit.dart';
import '../all_section/table_row_ui.dart';
import 'add_new_table_row_hold.dart';
import 'hold_image_picker.dart';
import 'one_hold.dart';

//! Tank transverse bulkhead

class HoldTankSection extends StatelessWidget {
  const HoldTankSection({
    super.key,
    required this.holdModel,
    required this.holdIndex,
  });

  final HoldModel holdModel;
  final int holdIndex;

  @override
  Widget build(BuildContext context) {
    OneHoldTankCubit cubit = BlocProvider.of<OneHoldTankCubit>(context);
    return BlocBuilder<OneHoldTankCubit, OneHoldTankState>(
      builder: (context, state) {
        List nameList = [];
        List valueList = [];
        state.tableMapTank.forEach((key, value) {
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
                child: Text(holdModel.nameTank),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.tableMapTank.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return TableRowUI(
                    name: nameList[index],
                    value: valueList[index],
                    delete: (name) {
                      BlocProvider.of<OneHoldTankCubit>(context)
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
                      builder: (context) => AddNewTableRowTankHold(
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
                imagesPath: state.listImagePathTank,
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
