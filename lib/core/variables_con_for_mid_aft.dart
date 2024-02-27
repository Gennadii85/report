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
  static const String description = '''
The outer shell plating was inspected from weather deck as far it was possible (port side) from aft to forward, and from shore (starboard side) from forward to aft. 
The external shell plating was affected with numerous of scratches and rust. Such a condition of hull plating could not affect the performance of the vessel.

''';
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
  static const List dataForMidAftSection = [
    [
      'Coating:',
      [
        'The external shell plating was good painted.',
        'The external shell plating was painted, but affected at some places by rust where paint cover was scratched or peeled off.',
        'The external shell plating was painted, but affected at some places by rust with scaling where paint cover was scratched.',
        'The plating some places was affected with rusty patches and streaks.',
        'Shell plating was noted good coated and revealed areas breakdown of coatings at the bulb area as result of fendering contact.',
        'Typical chain scratches and rust were apparent at the bow.',
        'It was presence of marine growth of fouling was visible on the hull.',
        'Negligible black spots and abrasion caused by the previous contacts with the rubber fenders of piers and/or tugs were observed in places.',
      ],
    ],
    [
      'Plating structure:',
      [
        'The plating was found in good condition, without visible damage / structural members.',
        'The plating was found in good condition. Only some minor indentation were visible on the hull.',
        'The plating was seen slightly pressed in between the frames / structural members.',
        'A few indentations apparent.',
        'The plating was affected by indentation at 3 places (10 x 10 x 3 cm) above waterline.',
        'The plating was affected by indentation at 3 places (10 x 10 x 3 cm) below waterline.',
        'A few indentations apparent.',
      ],
    ],
    [
      'Draft marks:',
      [
        'Draft marks, both port and starboard sides, were well painted and clearly visible.',
        'Draft marks, both port and starboard sides, were partly painted and visible.',
      ],
    ],
  ];

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
}
