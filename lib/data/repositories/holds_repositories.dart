import 'package:hive_flutter/hive_flutter.dart';

import '../../core/have_variables.dart';
import '../../core/variables_holds.dart';
import '../model/holds_model.dart';

class HoldsRepositories {
  void createHold() {
    // int nextHoldNumber = listHolds.length + 1;
    // int holdKey = nextHoldNumber;
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
    // int key = int.parse(holdKey);
    List listHolds = Hive.box(VarHave.boxHolds).get(VarHave.holds);
    listHolds.removeAt(index);
    // print(ddd);
    // ddd.remove(key);
    // print(ddd);

    Hive.box(VarHave.boxHolds).put(VarHave.holds, listHolds);
    // List list = ddd.entries.map((e) => e.value).toList();
    // Map newddd = list.asMap();
    // newddd.map((key, value) => Hive.box(VarHave.boxHolds).put(key, value));

    // Hive.box(VarHave.boxHolds).addAll(ddd.values);
  }

  void saveTableDada(
    String name,
    String value,
    String nameHoldSection,
    Map tableMap,
    int indexHold,
    int indexSection,
  ) {}
}
