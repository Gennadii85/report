// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AllHoldModel {
  final List<HoldModel> listAllHold;
  AllHoldModel({
    required this.listAllHold,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'allHold': listAllHold.map((x) => x.toMap()).toList(),
    };
  }

  factory AllHoldModel.fromMap(Map<String, dynamic> map) {
    return AllHoldModel(
      listAllHold: List<HoldModel>.from(
        (map['allHold'] as List<dynamic>).map<HoldModel>(
          (x) => HoldModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllHoldModel.fromJson(String source) =>
      AllHoldModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class HoldModel {
  final List<HoldSectionModel> listHoldSection;
  HoldModel({
    required this.listHoldSection,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'holdSection': listHoldSection.map((x) => x.toMap()).toList(),
    };
  }

  factory HoldModel.fromMap(Map<String, dynamic> map) {
    return HoldModel(
      listHoldSection: List<HoldSectionModel>.from(
        (map['holdSection'] as List<dynamic>).map<HoldSectionModel>(
          (x) => HoldSectionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory HoldModel.fromJson(String source) =>
      HoldModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class HoldSectionModel {
  final String name;
  final Map tableMap;
  final List<String> listImagePath;
  HoldSectionModel({
    required this.name,
    required this.tableMap,
    required this.listImagePath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'tableMap': tableMap,
      'imagePath': listImagePath,
    };
  }

  factory HoldSectionModel.fromMap(Map<String, dynamic> map) {
    return HoldSectionModel(
      name: map['name'] as String,
      tableMap: Map.from((map['tableMap'] as Map)),
      listImagePath: List.from((map['imagePath'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory HoldSectionModel.fromJson(String source) =>
      HoldSectionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}




  //  HoldSectionModel.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   tableMap = json['tableMap'];
  //   imagePath = List<String>.from(json['imagePath']) ;
  // }
