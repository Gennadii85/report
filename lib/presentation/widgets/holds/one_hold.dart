// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pdf_invoice_generator_flutter/presentation/pages/all_holds.dart';
import '../../../data/model/holds_model.dart';
import '../../../data/repositories/holds_repositories.dart';
import '../../cubit/one_hold/aft_section/aft_section_cubit.dart';
import '../../cubit/one_hold/forward_section/forward_section_cubit.dart';
import '../../cubit/one_hold/port_section/port_section_cubit.dart';
import '../../cubit/one_hold/starboard_section/starboard_section_cubit.dart';
import '../../cubit/one_hold/tank_section/tank_section_cubit.dart';
import '../all_section/app_bar_save_button.dart';
import 'hold_aft_section.dart';
import 'hold_forward_section.dart';
import 'hold_port_section.dart';
import 'hold_starboard_section.dart';
import 'hold_tank_section.dart';

class OneHold extends StatelessWidget {
  const OneHold({
    super.key,
    required this.holdIndex,
    required this.holdModel,
  });
  final int holdIndex;
  final HoldModel holdModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('HOLD № ${holdIndex + 1}'),
          centerTitle: true,
          leading: _backButton(context),
          actions: [
            AppBarSaveButton(
              function: (context) {
                OneHoldForwardCubit forwardCubit =
                    OneHoldForwardCubit(holdIndex, holdModel);
                OneHoldStarboardCubit starboardCubit =
                    OneHoldStarboardCubit(holdIndex, holdModel);
                OneHoldAftCubit aftCubit =
                    OneHoldAftCubit(holdIndex, holdModel);
                OneHoldPortCubit portCubit =
                    OneHoldPortCubit(holdIndex, holdModel);
                OneHoldTankCubit tankCubit =
                    OneHoldTankCubit(holdIndex, holdModel);
                HoldsRepositories().saveHold(
                  holdIndex,
                  forwardCubit,
                  starboardCubit,
                  aftCubit,
                  portCubit,
                  tankCubit,
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const AllHolds()),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HoldForwardSection(holdModel: holdModel, holdIndex: holdIndex),
              HoldStarboardSection(holdModel: holdModel, holdIndex: holdIndex),
              HoldAftSection(holdModel: holdModel, holdIndex: holdIndex),
              HoldPortSection(holdModel: holdModel, holdIndex: holdIndex),
              HoldTankSection(holdModel: holdModel, holdIndex: holdIndex),
            ],
          ),
        ),
      ),
    );
  }

  IconButton _backButton(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content:
              const Text('Все несохраненные изменения не попадут в отчет !!!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AllHolds(),
                ),
              ),
              child: const Text('Выйти'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Остаться'),
            ),
          ],
        ),
      ),
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }
}
