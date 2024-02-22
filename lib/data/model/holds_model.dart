import 'package:hive/hive.dart';

part 'holds_model.g.dart';

@HiveType(typeId: 1)
class HoldModel {
  @HiveField(15)
  HoldModel({
    required this.nameForward,
    required this.tableMapForward,
    required this.listImagePathForward,
    required this.nameStarboard,
    required this.tableMapStarboard,
    required this.listImagePathStarboard,
    required this.nameAft,
    required this.tableMapAft,
    required this.listImagePathAft,
    required this.namePort,
    required this.tableMapPort,
    required this.listImagePathPort,
    required this.nameTank,
    required this.tableMapTank,
    required this.listImagePathTank,
  });
  @HiveField(0)
  final String nameForward;
  @HiveField(1)
  final Map tableMapForward;
  @HiveField(2)
  final List<String> listImagePathForward;
  @HiveField(3)
  final String nameStarboard;
  @HiveField(4)
  final Map tableMapStarboard;
  @HiveField(5)
  final List<String> listImagePathStarboard;
  @HiveField(6)
  final String nameAft;
  @HiveField(7)
  final Map tableMapAft;
  @HiveField(8)
  final List<String> listImagePathAft;
  @HiveField(9)
  final String namePort;
  @HiveField(10)
  final Map tableMapPort;
  @HiveField(11)
  final List<String> listImagePathPort;
  @HiveField(12)
  final String nameTank;
  @HiveField(13)
  final Map tableMapTank;
  @HiveField(14)
  final List<String> listImagePathTank;
}
