// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holds_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HoldModelAdapter extends TypeAdapter<HoldModel> {
  @override
  final int typeId = 1;

  @override
  HoldModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HoldModel(
      nameForward: fields[0] as String,
      tableMapForward: (fields[1] as Map).cast<dynamic, dynamic>(),
      listImagePathForward: (fields[2] as List).cast<String>(),
      nameStarboard: fields[3] as String,
      tableMapStarboard: (fields[4] as Map).cast<dynamic, dynamic>(),
      listImagePathStarboard: (fields[5] as List).cast<String>(),
      nameAft: fields[6] as String,
      tableMapAft: (fields[7] as Map).cast<dynamic, dynamic>(),
      listImagePathAft: (fields[8] as List).cast<String>(),
      namePort: fields[9] as String,
      tableMapPort: (fields[10] as Map).cast<dynamic, dynamic>(),
      listImagePathPort: (fields[11] as List).cast<String>(),
      nameTank: fields[12] as String,
      tableMapTank: (fields[13] as Map).cast<dynamic, dynamic>(),
      listImagePathTank: (fields[14] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, HoldModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.nameForward)
      ..writeByte(1)
      ..write(obj.tableMapForward)
      ..writeByte(2)
      ..write(obj.listImagePathForward)
      ..writeByte(3)
      ..write(obj.nameStarboard)
      ..writeByte(4)
      ..write(obj.tableMapStarboard)
      ..writeByte(5)
      ..write(obj.listImagePathStarboard)
      ..writeByte(6)
      ..write(obj.nameAft)
      ..writeByte(7)
      ..write(obj.tableMapAft)
      ..writeByte(8)
      ..write(obj.listImagePathAft)
      ..writeByte(9)
      ..write(obj.namePort)
      ..writeByte(10)
      ..write(obj.tableMapPort)
      ..writeByte(11)
      ..write(obj.listImagePathPort)
      ..writeByte(12)
      ..write(obj.nameTank)
      ..writeByte(13)
      ..write(obj.tableMapTank)
      ..writeByte(14)
      ..write(obj.listImagePathTank);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HoldModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
