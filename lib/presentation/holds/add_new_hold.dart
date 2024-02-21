// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pdf_invoice_generator_flutter/presentation/holds/hold_section_table.dart';

import '../../core/variables_holds.dart';
import '../../data/model/holds_model.dart';

class AddNewHold extends StatefulWidget {
  const AddNewHold({
    super.key,
    required this.holdNumber,
    required this.holdModel,
  });
  final int holdNumber;
  final HoldModel holdModel;

  @override
  State<AddNewHold> createState() => _AddNewHoldState();
}

class _AddNewHoldState extends State<AddNewHold> {
  @override
  Widget build(BuildContext context) {
    final int indexHold = widget.holdNumber - 1;
    final List listHoldSection = widget.holdModel.listImagePathAft;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('HOLD № ${widget.holdNumber}'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //! Forward transverse bulkhead => listHoldSection.elementAt(0)
              HoldSectionTable(
                dataList: VarHolds.dataForwardTransverseBulkhead,
                holdNumber: widget.holdNumber,
                nameSection: VarHolds.forwardTransverseBulkheadTitle,
                model: listHoldSection.elementAt(0),
                route: MaterialPageRoute(
                  builder: (context) => AddNewHold(
                    holdNumber: widget.holdNumber,
                    holdModel: widget.holdModel,
                  ),
                ),
                indexHold: indexHold,
                indexSection: 0,
              ),
              //!  Image

              //! Starboard ship’s side => listHoldSection.elementAt(1)
              HoldSectionTable(
                dataList: VarHolds.dataForwardTransverseBulkhead,
                holdNumber: widget.holdNumber,
                nameSection: VarHolds.starboardShipsSideTitle,
                model: listHoldSection.elementAt(1),
                route: MaterialPageRoute(
                  builder: (context) => AddNewHold(
                    holdNumber: widget.holdNumber,
                    holdModel: widget.holdModel,
                  ),
                ),
                indexHold: indexHold,
                indexSection: 1,
              ),
              //!  Image

              //! Aft transverse bulkhead => listHoldSection.elementAt(2)
              HoldSectionTable(
                dataList: VarHolds.dataForwardTransverseBulkhead,
                holdNumber: widget.holdNumber,
                nameSection: VarHolds.aftTransverseBulkheadTitle,
                model: listHoldSection.elementAt(2),
                route: MaterialPageRoute(
                  builder: (context) => AddNewHold(
                    holdNumber: widget.holdNumber,
                    holdModel: widget.holdModel,
                  ),
                ),
                indexHold: indexHold,
                indexSection: 2,
              ),
              //!  Image

              //! Port ships side => listHoldSection.elementAt(3)
              HoldSectionTable(
                dataList: VarHolds.dataForwardTransverseBulkhead,
                holdNumber: widget.holdNumber,
                nameSection: VarHolds.portShipsSideTitle,
                model: listHoldSection.elementAt(3),
                route: MaterialPageRoute(
                  builder: (context) => AddNewHold(
                    holdNumber: widget.holdNumber,
                    holdModel: widget.holdModel,
                  ),
                ),
                indexHold: indexHold,
                indexSection: 3,
              ),
              //!  Image

              //! Tank tops => listHoldSection.elementAt(4)
              HoldSectionTable(
                dataList: VarHolds.dataForwardTransverseBulkhead,
                holdNumber: widget.holdNumber,
                nameSection: VarHolds.tankTopsTitle,
                model: listHoldSection.elementAt(4),
                route: MaterialPageRoute(
                  builder: (context) => AddNewHold(
                    holdNumber: widget.holdNumber,
                    holdModel: widget.holdModel,
                  ),
                ),
                indexHold: indexHold,
                indexSection: 4,
              ),
              //!  Image
            ],
          ),
        ),
      ),
    );
  }
}
