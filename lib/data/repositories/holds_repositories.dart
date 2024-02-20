import 'package:hive_flutter/hive_flutter.dart';

import '../../core/have_variables.dart';
import '../../core/variables_holds.dart';
import '../model/holds_model.dart';

class HoldsRepositories {
  void createHold() {
    String jsonString = Hive.box(VarHave.boxHolds).get(VarHave.holds) ?? '';
    if (jsonString.isEmpty) {
      List<HoldModel> listHoldModel = [
        HoldModel(
          listHoldSection: [
            HoldSectionModel(
                name: VarHolds.forwardTransverseBulkheadTitle,
                tableMap: {},
                listImagePath: []),
            HoldSectionModel(
                name: VarHolds.starboardShipsSideTitle,
                tableMap: {},
                listImagePath: []),
            HoldSectionModel(
                name: VarHolds.aftTransverseBulkheadTitle,
                tableMap: {},
                listImagePath: []),
            HoldSectionModel(
                name: VarHolds.portShipsSideTitle,
                tableMap: {},
                listImagePath: []),
            HoldSectionModel(
                name: VarHolds.tankTopsTitle, tableMap: {}, listImagePath: []),
          ],
        ),
      ];

      String nevJsonString = AllHoldModel(listAllHold: listHoldModel).toJson();
      Hive.box(VarHave.boxHolds).put(VarHave.holds, nevJsonString);
    } else {
      List<HoldModel> listHoldModel =
          AllHoldModel.fromJson(jsonString).listAllHold;
      HoldModel nev = HoldModel(
        listHoldSection: [
          HoldSectionModel(
              name: VarHolds.forwardTransverseBulkheadTitle,
              tableMap: {},
              listImagePath: []),
          HoldSectionModel(
              name: VarHolds.starboardShipsSideTitle,
              tableMap: {},
              listImagePath: []),
          HoldSectionModel(
              name: VarHolds.aftTransverseBulkheadTitle,
              tableMap: {},
              listImagePath: []),
          HoldSectionModel(
              name: VarHolds.portShipsSideTitle,
              tableMap: {},
              listImagePath: []),
          HoldSectionModel(
              name: VarHolds.tankTopsTitle, tableMap: {}, listImagePath: []),
        ],
      );
      listHoldModel.add(nev);
      String nevJsonString = AllHoldModel(listAllHold: listHoldModel).toJson();
      Hive.box(VarHave.boxHolds).put(VarHave.holds, nevJsonString);
    }
  }

  List<HoldModel> getAllHolds(String jsonString) {
    List<HoldModel> listModelHold = [];
    if (jsonString.isEmpty) {
      List<HoldModel> listModelHold = [
        HoldModel(
          listHoldSection: [
            HoldSectionModel(
                name: VarHolds.forwardTransverseBulkheadTitle,
                tableMap: {},
                listImagePath: []),
            HoldSectionModel(
                name: VarHolds.starboardShipsSideTitle,
                tableMap: {},
                listImagePath: []),
            HoldSectionModel(
                name: VarHolds.aftTransverseBulkheadTitle,
                tableMap: {},
                listImagePath: []),
            HoldSectionModel(
                name: VarHolds.portShipsSideTitle,
                tableMap: {},
                listImagePath: []),
            HoldSectionModel(
                name: VarHolds.tankTopsTitle, tableMap: {}, listImagePath: []),
          ],
        ),
      ];
      return listModelHold;
    } else {
      listModelHold = AllHoldModel.fromJson(jsonString).listAllHold;
    }

    return listModelHold;
  }

  // HoldModel getOneHold(int holdNumber, String nameSection) {
  //   late HoldModel holdModel;
  //   String jsonString = Hive.box(VarHave.boxHolds).get(VarHave.holds);
  //   // if (jsonString.isEmpty) {
  //   //   model = HoldSectionModel(imagePath: [], name: nameSection, tableMap: {});
  //   // } else {
  //   final List<HoldModel> listHoldModel =
  //       AllHoldModel.fromJson(jsonString).listAllHold;
  //   holdModel = listHoldModel.elementAt(holdNumber - 1);

  //   // }
  //   return holdModel;
  // }

  // List<String> getImages(HoldSectionModel model) {
  //   late List<String> images;
  //   images = model.listImagePath;
  //   return images;
  // }

  void saveTableDada(
    String name,
    String value,
    String nameHoldSection,
    Map tableMap,
    int indexHold,
    int indexSection,
  ) {
    // tableMap.addAll({name: value});
    String jsonString = Hive.box(VarHave.boxHolds).get(VarHave.holds);
    List<HoldModel> listHolds = HoldsRepositories().getAllHolds(jsonString);

    listHolds.map(
        (el) => el.listHoldSection[indexHold].tableMap.addAll({name: value}));

    final String jsonSaved = AllHoldModel(listAllHold: listHolds).toJson();
    print(jsonSaved);
    Hive.box(VarHave.boxHolds).put(VarHave.holds, jsonSaved);
  }
}
