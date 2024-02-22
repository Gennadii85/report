// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pdf_invoice_generator_flutter/presentation/pages/holds.dart';
import '../../data/model/holds_model.dart';
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
          actions: [
            AppBarSaveButton(
              function: (context) {
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
}
