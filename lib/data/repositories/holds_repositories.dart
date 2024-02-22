import 'package:hive_flutter/hive_flutter.dart';

import '../../core/have_variables.dart';
import '../../core/variables_holds.dart';
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

  void deleteTableRow(String name) {}

  void saveTableRow(
    String name,
    String value,
    Map tableMap,
    int indexHold,
  ) {
    List listHolds = Hive.box(VarHave.boxHolds).get(VarHave.holds);
    HoldModel oneHold = listHolds.elementAt(indexHold);
  }
}
