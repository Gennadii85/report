import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/holds_model.dart';
import '../cubit/one_hold/forward_section/one_hold_forward_cubit.dart';
import '../widgets/table_row_ui.dart';
import 'add_new_table_row_hold.dart';
import 'one_hold.dart';

class HoldForwardSection extends StatelessWidget {
  const HoldForwardSection({
    super.key,
    required this.holdModel,
    required this.holdIndex,
  });

  final HoldModel holdModel;
  final int holdIndex;

  @override
  Widget build(BuildContext context) {
    OneHoldForwardCubit cubit = BlocProvider.of<OneHoldForwardCubit>(context);
    return BlocBuilder<OneHoldForwardCubit, OneHoldForwardState>(
      builder: (context, state) {
        return Column(
          children: [
            //! Forward transverse bulkhead

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(holdModel.nameForward),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: state.tableMapForward.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) {
                List nameList = [];
                List valueList = [];
                state.tableMapForward.forEach((key, value) {
                  nameList.add(key);
                  valueList.add(value);
                });
                return TableRowUI(
                  name: nameList[index],
                  value: valueList[index],
                  delete: (name) {
                    BlocProvider.of<OneHoldForwardCubit>(context)
                        .deleteTableRow(name);
                  },
                );
              }),
            ),
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
          ],
        );
      },
    );
  }
}
