import 'package:flutter/material.dart';

class VarAccEngCar {
  static const titleStile =
      TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static const String accommodationTitle = 'ACCOMMODATION';
  static const String engineRoomTitle = 'ENGINE ROOM';
  static const String cargoCompartmentsTitle = 'CARGO COMPARTMENTS';

  static const List<List> dataAccommodation = [
    [
      'Accommodation',
      [
        'The accommodation including ladders, hand-railings, pipes and ceiling were found in good condition, painted and fitted for human habitation.',
        'The gangways on each side does not have visible mechanical damages, were structurally sound and painted, generally in good condition. Appropriate marking were applied.',
      ]
    ]
  ];
  static const List<List> dataEngineRoom = [
    [
      'Engine Room',
      [
        'The engine room and its machineries were found apparently in satisfactory condition. No damaged or non-operative equipment were noticed during the survey.',
        'Oil leaks locally apparent.',
      ]
    ]
  ];
  static const List<List> dataCargoCompartments = [
    [
      'Cranes',
      [
        'Four cranes with SWL 30 mt each were found apparently in satisfactory condition, but not seen working. Their windows were found intact and reasonably clean. Steel structures of platforms were structurally sound and painted. Steel wire ropes were apparently in satisfactory condition.',
        'Oil leaks inside of cranes pumps rooms were noted.',
      ],
    ],
    [
      'Marking',
      [
        'SWL marking on cranes was clearly marked with paint.',
      ],
    ],
    [
      'Grabs',
      [
        'Four grabs located nearby the cranes on special pedestals were found in fair condition.',
        'No grabs fitted',
      ],
    ],
  ];
}
