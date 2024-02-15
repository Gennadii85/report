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
        'Deck plating was free from damage and was painted, but affected at some places by rust where paint cover was scratched. Appropriate marking was applied.',
        'The external shell plating was painted, but affected at some places by rust where paint cover was scratched or peel off.',
        'Deck plating was free from damage and well painted up. Appropriate marking was applied.',
      ],
    ],
    [
      'Hand railing',
      ['444', '555', '666'],
    ],
    [
      'Deck fittings',
      ['777', '888', '999'],
    ],
  ];

  static const List dataForecastleDeck = [
    [
      'Plating',
      [
        '111111 Deck plating was free from damage and was painted, but affected at some places by rust where paint cover was scratched.',
        '22222 Deck plating was free from damage and was painted, but affected at some places by rust where paint cover was scratched.',
        '333333 Deck plating was free from damage and was painted, but affected at some places by rust where paint cover was scratched.',
      ]
    ],
    [
      'Bulwark and Railing',
      [
        '1111 The bulwark was well painted and noted in structurally sound condition.The railing were bent at the aft part in forecastle.',
        '2222 The bulwark was well painted and noted in structurally sound condition.The railing were bent at the aft part in forecastle.',
        '3333 The bulwark was well painted and noted in structurally sound condition.The railing were bent at the aft part in forecastle.',
      ]
    ],
    [
      'Mooring arrangements',
      [
        '1111 Mooring winches and equipment visually were in fair condition, well painted, apparently well maintained up, damage free.',
        '2222 Mooring winches and equipment visually were in fair condition, well painted, apparently well maintained up, damage free.',
        '3333 Mooring winches and equipment visually were in fair condition, well painted, apparently well maintained up, damage free.',
      ]
    ]
  ];

  static const List dataStarboardSide = [
    [
      'Plating',
      [
        '44444 Deck plating was free from damage and was painted, but affected at some places by rust where paint cover was scratched. Appropriate marking was applied.',
        '55555 Deck plating was free from damage and was painted, but affected at some places by rust where paint cover was scratched. Appropriate marking was applied.',
        '66666 Deck plating was free from damage and was painted, but affected at some places by rust where paint cover was scratched. Appropriate marking was applied.',
      ]
    ],
    [
      'Hand railing',
      [
        '44444 The railing was bent at some places. Painted, but affected at some places by rust where paint cover was scratched.',
        '55555 The railing was bent at some places. Painted, but affected at some places by rust where paint cover was scratched.',
        '66666 The railing was bent at some places. Painted, but affected at some places by rust where paint cover was scratched.',
      ]
    ],
    [
      'Deck fittings',
      [
        '4444 Deck lines were situated along hatch coamings and between holds, were at some places by rust scale but without any leakages and properly marked.',
        '5555 Deck lines were situated along hatch coamings and between holds, were at some places by rust scale but without any leakages and properly marked.',
        '6666 Deck lines were situated along hatch coamings and between holds, were at some places by rust scale but without any leakages and properly marked.',
      ]
    ],
  ];

  static const List dataPoopDeck = [
    [
      'Plating',
      [
        'Deck plating was free from damage and was painted, but affected at some places by rust where paint cover was scratched. Appropriate marking was applied.',
        'The external shell plating was painted, but affected at some places by rust where paint cover was scratched or peel off.',
        'Deck plating was free from damage and well painted up. Appropriate marking was applied.',
      ],
    ],
    [
      'Hand railing',
      ['444', '555', '666'],
    ],
    [
      'Mooring arrangements',
      [
        '1111 Mooring winches and equipment visually were in fair condition, well painted, apparently well maintained up, damage free.',
        '2222 Mooring winches and equipment visually were in fair condition, well painted, apparently well maintained up, damage free.',
        '3333 Mooring winches and equipment visually were in fair condition, well painted, apparently well maintained up, damage free.',
      ]
    ]
  ];
}
