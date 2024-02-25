import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_invoice_generator_flutter/presentation/cubit/one_hold/starboard_section/starboard_section_cubit.dart';

import '../../core/have_variables.dart';
import '../../core/variables_holds.dart';
import '../../presentation/cubit/one_hold/aft_section/aft_section_cubit.dart';
import '../../presentation/cubit/one_hold/forward_section/forward_section_cubit.dart';
import '../../presentation/cubit/one_hold/port_section/port_section_cubit.dart';
import '../../presentation/cubit/one_hold/tank_section/tank_section_cubit.dart';
import '../model/holds_model.dart';

class HoldsRepositories {
  void createHold() {
    List listHolds = Hive.box(VarHave.boxHolds).get(VarHave.holds) ?? [];
    HoldModel holdExample = HoldModel(
      nameForward: VarHolds.forwardTransverseBulkheadTitle,
      tableMapForward: {},
      listImagePathForward: [],
      nameStarboard: VarHolds.starboardShipsSideTitle,
      tableMapStarboard: {},
      listImagePathStarboard: [],
      nameAft: VarHolds.aftTransverseBulkheadTitle,
      tableMapAft: {},
      listImagePathAft: [],
      namePort: VarHolds.portShipsSideTitle,
      tableMapPort: {},
      listImagePathPort: [],
      nameTank: VarHolds.tankTopsTitle,
      tableMapTank: {},
      listImagePathTank: [],
    );
    listHolds.add(holdExample);
    Hive.box(VarHave.boxHolds).put(VarHave.holds, listHolds);
  }

  void deleteHold(int index) {
    List listHolds = Hive.box(VarHave.boxHolds).get(VarHave.holds);
    listHolds.removeAt(index);
    Hive.box(VarHave.boxHolds).put(VarHave.holds, listHolds);
  }

  void saveHold(
      int index,
      OneHoldForwardCubit forwardCubit,
      OneHoldStarboardCubit starboardCubit,
      OneHoldAftCubit aftCubit,
      OneHoldPortCubit portCubit,
      OneHoldTankCubit tankCubit) {
    List listHolds = Hive.box(VarHave.boxHolds).get(VarHave.holds);
    listHolds.removeAt(index);
    HoldModel nevHold = HoldModel(
      nameForward: forwardCubit.holdModel.nameForward,
      tableMapForward: forwardCubit.state.tableMapForward,
      listImagePathForward: forwardCubit.state.listImagePathForward,
      nameStarboard: forwardCubit.holdModel.nameStarboard,
      tableMapStarboard: starboardCubit.state.tableMapStarboard,
      listImagePathStarboard: starboardCubit.state.listImagePathStarboard,
      nameAft: forwardCubit.holdModel.nameAft,
      tableMapAft: aftCubit.state.tableMapAft,
      listImagePathAft: aftCubit.state.listImagePathAft,
      namePort: forwardCubit.holdModel.namePort,
      tableMapPort: portCubit.state.tableMapPort,
      listImagePathPort: portCubit.state.listImagePathPort,
      nameTank: forwardCubit.holdModel.nameTank,
      tableMapTank: tankCubit.state.tableMapTank,
      listImagePathTank: tankCubit.state.listImagePathTank,
    );
    listHolds.insert(index, nevHold);
    Hive.box(VarHave.boxHolds).put(VarHave.holds, listHolds);
  }
}
