// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pdf_invoice_generator_flutter/presentation/pages/all_holds.dart';
import '../../data/model/holds_model.dart';
import '../../data/repositories/holds_repositories.dart';
import '../cubit/one_hold/forward_section/one_hold_forward_cubit.dart';
import '../widgets/app_bar_save_button.dart';
import 'hold_forward_section.dart';

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
                HoldsRepositories().saveHold(holdIndex, forwardCubit);
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
              HoldForwardSection(
                holdModel: holdModel,
                holdIndex: holdIndex,
              ),

              //! Starboard ship’s side

              // //! Aft transverse bulkhead

              // //! Port ships side

              // //! Tank tops
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
