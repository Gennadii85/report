import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/holds_model.dart';
import '../cubit/one_hold/one_hold_cubit.dart';
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
