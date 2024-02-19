import 'package:hive_flutter/hive_flutter.dart';

import '../../core/have_variables.dart';
import '../model/holds_model.dart';

class HoldsRepositories {
  HoldSectionModel getModel(int holdNumber, String nameSection) {
    late HoldSectionModel model;
    String jsonString = Hive.box(VarHave.boxHolds).get(VarHave.holds) ?? '';
    if (jsonString.isEmpty) {
      model = HoldSectionModel(imagePath: [], name: nameSection, tableMap: {});
    } else {
      final HoldModel allModel = HoldModel.fromJson(jsonString);
      model = allModel.holdSection[holdNumber - 1];
    }
    return model;
  }

  List<String> getImages(HoldSectionModel model) {
    late List<String> images;
    images = model.imagePath;
    return images;
  }

  void saveDada(
      String name, String value, String? nameHoldSection, Map? tableMap) {
    tableMap!.addAll({name: value});

    final String jsonSaved = HoldSectionModel(
      name: nameHoldSection!,
      tableMap: tableMap,
      imagePath: [],
    ).toJson();
    print(jsonSaved);
    Hive.box(VarHave.boxHolds).get(VarHave.holds);
  }
}
