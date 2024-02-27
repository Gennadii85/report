import 'package:flutter/material.dart';

class VarWeather {
  static const titleStile =
      TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static const addTableTitleStile =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static const addTableValueStile =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
  static const String portSideTitle = 'Port side, weather deck and fittings.';
  static const String forecastleDeckTitle = 'Forecastle deck and fittings.';
  static const String starboardSideTitle =
      'Starboard side, weather deck and fittings.';
  static const String poopDeckTitle = 'Poop deck and fittings.';

  static const List dataPortSide = [
    [
      'Plating',
      [
        'Deck plating was free from damage and well painted up. Appropriate marking was applied.',
        'Deck plating was free from damage and was painted, but affected at some places by rust where paint cover was scratched.',
      ],
    ],
    [
      'Hand railing',
      [
        'Free from damage and well painted up. Was generally noted in apparently structurally sound condition.',
        'Not damaged, painted, but in some places the paint has scratched or peeled off.',
        'The railing was bent at some places. Painted up.',
        'The hand railing was well painted, few rails and stanchions were slightly bent/uneven.',
      ],
    ],
    [
      'Deck fittings',
      [
        'Fittings on deck were damage free. Deck lines were situated along hatch coamings and between holds, were in satisfactory condition without any leakages.',
        'Deck lines were situated along hatch coamings and between holds, were in good condition without any leakages and properly marked. The walking platforms above the pipelines were locally damaged / bent / partly unsafe.',
      ],
    ],
  ];

  static const List dataForecastleDeck = [
    [
      'Plating',
      [
        'Deck plating was free from damage and well painted up. Appropriate marking was applied.',
        'Deck plating was free from damage and was painted, but affected at some places by rust where paint cover was scratched.',
        'Appropriate marking missing.',
      ],
    ],
    [
      'Bulwark',
      [
        'The bulwark was found apparently in sound structural condition and well painted up.',
        'Satisfactorily painted bulwark was found with following damages: _______________________',
      ]
    ],
    [
      'Mooring arrangements',
      [
        'Windlasses, mooring winches and associated equipment visually were found to be in satisfactory condition and apparently well maintained up.',
        'However, following deficiencies were noted:',
        'Platforms and steps damaged/unsafe',
        'Oil leaks from mooring equipment',
        'Poor condition of mooring lines.',
      ]
    ]
  ];

  static const List dataStarboardSide = [
    [
      'Plating',
      [
        'Deck plating was free from damage and well painted up. Appropriate marking was applied.',
        'Deck plating was free from damage and was painted, but affected at some places by rust where paint cover was scratched.',
      ],
    ],
    [
      'Hand railing',
      [
        'Structurally sound and damage free condition, apparently well painted up.',
        'Structurally sound, but some areas of paint were scratched or peeled off.',
        'The hand railing was well painted, a few rails and stanchions were slightly bent/uneven.',
        'The railing was bent at some places with paint cover locally missing.',
      ]
    ],
    [
      'Deck fittings',
      [
        'Fittings on deck were apparently in satisfactory condition and damage free. Deck lines situated along hatch coamings and between holds were in satisfactory condition and leakage free.',
        'Deck lines situated along hatch coamings and between holds were in satisfactory condition and leakage free. The walking platforms above the pipelines were locally damaged / bent / partly unsafe.',
      ]
    ],
  ];

  static const List dataPoopDeck = [
    [
      'Plating',
      [
        'Deck plating was free from damage and well painted up. Appropriate marking was applied.',
        'Deck plating was free from damage and was painted, but affected at some places by rust where paint cover was scratched.',
        'Appropriate marking missing.',
      ],
    ],
    [
      'Bulwark',
      [
        'The bulwark was found apparently in sound structural condition and well painted up.',
        'Satisfactorily painted bulwark was found with following damages: ____________________',
      ],
    ],
    [
      'Mooring arrangements',
      [
        'Windlasses, mooring winches and associated equipment visually were found to be in satisfactory condition and apparently well maintained up.',
        'However, following deficiencies were noted:',
        'Platforms and steps damaged/unsafe',
        'Oil leaks from mooring equipment',
        'Poor condition of mooring lines.',
      ]
    ]
  ];
}
