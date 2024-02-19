// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HoldModel {
  List<HoldSectionModel> holdSection;
  HoldModel({
    required this.holdSection,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'holdSection': holdSection.map((x) => x.toMap()).toList(),
    };
  }

  factory HoldModel.fromMap(Map<String, dynamic> map) {
    return HoldModel(
      holdSection: List<HoldSectionModel>.from(
        (map['holdSection'] as List<HoldSectionModel>).map<HoldSectionModel>(
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
  String name;
  Map tableMap;
  List<String> imagePath;
  HoldSectionModel({
    required this.name,
    required this.tableMap,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'tableMap': tableMap,
      'imagePath': imagePath,
    };
  }

  factory HoldSectionModel.fromMap(Map<String, dynamic> map) {
    return HoldSectionModel(
      name: map['name'] as String,
      tableMap: Map.from((map['tableMap'] as Map)),
      imagePath: List<String>.from((map['imagePath'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory HoldSectionModel.fromJson(String source) =>
      HoldSectionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
