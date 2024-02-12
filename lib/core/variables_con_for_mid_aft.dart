import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_invoice_generator_flutter/core/have_variables.dart';

class VarForMidAft {
  String? initDynamicHeader1 = Hive.box(VarHave.boxCondition).get('title');
  String? initDescription = Hive.box(VarHave.boxCondition).get('description');
  static const String dynamicHeader1 =
      'ON-HIRE CONDITION SURVEY AT (name port) PORT, (city name) ON (current date).';
  static const String header2 = 'SPECIFIC DAMAGES AND DEFECTS NOTED ON BOARD';
  static const String header3 = 'OUTER SHELL PLATING';
  static const String description =
      'The outer shell plating was inspected from shore (starboard side) and from main deck (port side) from forward to aft. The external shell plating was affected with insignificant scratches, rusty streaks and negligible black spots and abrasion caused by the previous contacts with the rubber fenders of piers and/or tugs. Some deep localized indentation apparent at the areas o tugboat contacts. Signs of marine growth were note during the survey. Such a condition of hull plating could not affect the performance of the vessel.';
  static const titleStile =
      TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static const List<String> subTitleListForward = [
    'Starboard side - ',
    'Port side - ',
    'Port and Starboard - ',
  ];
  static const List<String> subTitleListMiddle = [
    'Starboard side - ',
    'Port side - ',
    'Port and Starboard - ',
  ];
  static const List<String> subTitleListAft = [
    'Starboard side - ',
    'Port side - ',
    'Port and Starboard - ',
  ];
}

class VarTableForMidAft {
  //? значения для InitialState Cubits для таблиц  Forward Section
  String? coatingForward = Hive.box(VarHave.boxForwardSection).get('coating');
  String? platingForward = Hive.box(VarHave.boxForwardSection).get('plating');
  String? draftForward = Hive.box(VarHave.boxForwardSection).get('draft');

  //? значения для InitialState Cubits для таблиц  Middle Section
  String? coatingMiddle = Hive.box(VarHave.boxMiddleSection).get('coating');
  String? platingMiddle = Hive.box(VarHave.boxMiddleSection).get('plating');
  String? draftMiddle = Hive.box(VarHave.boxMiddleSection).get('draft');

  //? значения для InitialState Cubits для таблиц  Aft Section
  String? coatingAft = Hive.box(VarHave.boxAftSection).get('coating');
  String? platingAft = Hive.box(VarHave.boxAftSection).get('plating');
  String? draftAft = Hive.box(VarHave.boxAftSection).get('draft');

  //? значения для 'Starboard side – ****** Section' первая строка - 'coating'
  static const String coatingParam1 = '''
Satisfactory condition. Typical chain scratches and rust were apparent at the bow. 
  ''';
  static const String coatingParam2 = '''
The external shell plating was painted, but affected at some places by rust where paint cover was scratched.
Typical chain scratches and rust were apparent at the bow. 
  ''';
  static const String coatingParam3 = '''
Satisfactory condition. Typical chain scratches and rust were apparent at the bow. 
The plating some places was affected with rusty patches and streaks.
It was presence of marine growth of fouling was visible on the hull.
  ''';
  static const String coatingParam4 = '''
The external shell plating was painted, but affected at some places by rust where paint cover was scratched or peeled off.
  ''';
  static const String coatingParam5 = '''
more
''';
  static const List<String> coatingList = [
    coatingParam1,
    coatingParam2,
    coatingParam3,
    coatingParam4,
    coatingParam5,
  ];
  static const List<DropdownMenuEntry<String>> coatingListItems = [
    DropdownMenuEntry(value: coatingParam1, label: '1'),
    DropdownMenuEntry(value: coatingParam2, label: '2'),
    DropdownMenuEntry(value: coatingParam3, label: '3'),
    DropdownMenuEntry(value: coatingParam4, label: '4'),
    DropdownMenuEntry(value: coatingParam5, label: '5'),
  ];
  //? значения для 'Starboard side – ****** Section' вторая строка - 'plating'
  static const String platingParam1 = '''
The plating was seen slightly pressed in between the frames / structural members.
Affected by rust at some places on the bulb bow. 
  ''';
  static const String platingParam2 = '''
The plating was seen slightly pressed in between the frames / structural members.
The plating was affected by indentation at 3 places (10 x 10 x 3 cm) above waterline.
  ''';
  static const String platingParam3 = '''
The plating was seen slightly pressed in between the frames / structural members.
  ''';
  static const String platingParam4 = '''
The plating was seen slightly pressed in between the frames / structural members.
Plating was affected by indentation up to 4 cm, in area of the bulb bow & indentation up to 4 cm in area of the draft marks 6 M.
  ''';
  static const String platingParam5 = '''
The plating was seen slightly pressed in between the frames / structural members.
Noticeable indentations with the maxi depth from 20 mm to 30 mm.
The plating was affected by indentation (25 x 25 x 2 cm) above waterline.
''';
  static const List<String> platingList = [
    platingParam1,
    platingParam2,
    platingParam3,
    platingParam4,
    platingParam5,
  ];
  static const List<DropdownMenuEntry<String>> platingListItems = [
    DropdownMenuEntry(value: platingParam1, label: '1'),
    DropdownMenuEntry(value: platingParam2, label: '2'),
    DropdownMenuEntry(value: platingParam3, label: '3'),
    DropdownMenuEntry(value: platingParam4, label: '4'),
    DropdownMenuEntry(value: platingParam5, label: '5'),
  ];

  //? значения для 'Starboard side – ****** Section' вторая строка - 'draft'
  static const String draftParam1 = '''
Draft marks were clearly visible.
  ''';
  static const String draftParam2 = '''
Draft marks, both port and starboard sides, were not painted but visible.
  ''';
  static const String draftParam3 = '''
Draft marks, both port and starboard sides, were not properly painted but legible.
  ''';
  static const String draftParam4 = '''
Draft marks, both port and starboard sides were properly painted.
  ''';
  static const String draftParam5 = '''
more
''';
  static const List<String> draftList = [
    draftParam1,
    draftParam2,
    draftParam3,
    draftParam4,
    draftParam5,
  ];
  static const List<DropdownMenuEntry<String>> draftListItems = [
    DropdownMenuEntry(value: draftParam1, label: '1'),
    DropdownMenuEntry(value: draftParam2, label: '2'),
    DropdownMenuEntry(value: draftParam3, label: '3'),
    DropdownMenuEntry(value: draftParam4, label: '4'),
    DropdownMenuEntry(value: draftParam5, label: '5'),
  ];
}
