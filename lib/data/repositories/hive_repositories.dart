import 'package:hive_flutter/hive_flutter.dart';

import '../../core/have_variables.dart';

class HiveRepositories {
  Future openAllBox() async {
    await Hive.openBox(VarHave.boxCondition);
    await Hive.openBox(VarHave.boxForwardSection);
    await Hive.openBox(VarHave.boxMiddleSection);
    await Hive.openBox(VarHave.boxAftSection);
    await Hive.openBox(VarHave.boxPortSide);
    await Hive.openBox(VarHave.boxForecastleDeck);
    await Hive.openBox(VarHave.boxStarboardSide);
    await Hive.openBox(VarHave.boxPoopDeck);
    await Hive.openBox(VarHave.boxAccEngCar);
    await Hive.openBox(VarHave.boxHolds);
  }

  Future deleteAllBoxValue(boatName) async {
    Hive.box(VarHave.boxCondition).clear();
    await Hive.box(VarHave.boxForwardSection).clear();
    await Hive.box(VarHave.boxMiddleSection).clear();
    await Hive.box(VarHave.boxAftSection).clear();
    await Hive.box(VarHave.boxPortSide).clear();
    await Hive.box(VarHave.boxForecastleDeck).clear();
    await Hive.box(VarHave.boxStarboardSide).clear();
    await Hive.box(VarHave.boxPoopDeck).clear();
    await Hive.box(VarHave.boxAccEngCar).clear();
    await Hive.box(VarHave.boxHolds).clear();
    Hive.box(VarHave.boxCondition).put(VarHave.boatName, boatName);
  }
}
