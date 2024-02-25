import 'package:flutter/material.dart';

class VarWeather {
  static const titleStile =
      TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
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
      ],
    ],
    [
      'Bulwark',
      [
        'The railing was well painted up. Was generally noted in apparently structurally sound condition.',
        'The bulwark was well painted and noted in structurally sound condition.',
        'Not damaged, painted, but in some places the paint has peeled off.',
      ]
    ],
    [
      'Mooring arrangements',
      [
        'Mooring winches and equipment visually were in satisfactory condition, good painted, apparently well maintained up, damage free.',
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
        'Free from damage and well painted up. Was generally noted in apparently structurally sound condition.',
        'Not damaged, painted, but in some places the paint has scratched or peeled off.',
        'The railing was bent at some places. Painted up.',
        'The hand railing was well painted, few rails and stanchions were slightly bent/uneven.',
      ]
    ],
    [
      'Deck fittings',
      [
        'Fittings on deck were damage free. Deck lines were situated along hatch coamings and between holds, were in satisfactory condition without any leakages.',
        'Deck lines were situated along hatch coamings and between holds, were in good condition without any leakages and properly marked. The walking platforms above the pipelines were locally damaged / bent / partly unsafe.',
      ]
    ],
  ];

  static const List dataPoopDeck = [
    [
      'Plating',
      [
        'Deck plating was free from damage and well painted up. Appropriate marking was applied.',
        'Deck plating was free from damage and was painted, but affected at some places by rust where paint cover was scratched.',
      ],
    ],
    [
      'Bulwark',
      [
        'Free from damage and well painted up. Was generally noted in apparently structurally sound condition.',
        'Not damaged, painted, but in some places the paint has scratched or peeled off.',
      ],
    ],
    [
      'Mooring arrangements',
      [
        'Mooring winches and equipment visually were in satisfactory condition, good painted, apparently well maintained up, damage free.',
      ]
    ]
  ];
}
