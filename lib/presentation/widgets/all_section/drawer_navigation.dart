import 'package:flutter/material.dart';
import '../../../entities/drawer_entities.dart';
import '../../pages/accommodation.dart';
import '../../pages/aft_section.dart';
import '../../pages/cargo_compartments.dart';
import '../../pages/condition.dart';
import '../../pages/engine_room.dart';
import '../../pages/forecastle_deck.dart';
import '../../pages/forward_section.dart';
import '../../pages/all_holds.dart';
import '../../pages/home_page.dart';
import '../../pages/middle_section.dart';
import '../../pages/poop_deck.dart';
import '../../pages/port_side.dart';
import '../../pages/starboard_side.dart';
import '../../pages/weather_decks.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerEntities(
            text: 'Start PAGE',
            function: (text) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            ),
          ),
          DrawerEntities(
            text: 'CONDITION',
            function: (text) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Condition(titleAppBar: text),
              ),
            ),
          ),
          DrawerEntities(
            text: 'Forward Section',
            function: (text) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ForwardSection(titleAppBar: text),
              ),
            ),
          ),
          DrawerEntities(
            text: 'Middle Section',
            function: (text) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MiddleSection(titleAppBar: text),
              ),
            ),
          ),
          DrawerEntities(
            text: 'Aft Section',
            function: (text) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AftSection(titleAppBar: text),
              ),
            ),
          ),
          DrawerEntities(
            text: 'WEATHER DECKS',
            function: (text) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WeatherDecks(titleAppBar: text),
              ),
            ),
          ),
          DrawerEntities(
            text: 'Port side, weather deck and fittings',
            function: (text) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PortSide(),
              ),
            ),
          ),
          DrawerEntities(
            text: 'Forecastle deck and fittings',
            function: (text) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ForecastleDeck(),
              ),
            ),
          ),
          DrawerEntities(
            text: 'Starboard side, weather deck and fittings',
            function: (text) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const StarboardSide(),
              ),
            ),
          ),
          DrawerEntities(
            text: 'Poop deck and fittings',
            function: (text) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PoopDeck(),
              ),
            ),
          ),
          DrawerEntities(
            text: 'ACCOMMODATION',
            function: (text) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Accommodation(),
              ),
            ),
          ),
          DrawerEntities(
            text: 'ENGINE ROOM',
            function: (text) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EngineRoom(),
              ),
            ),
          ),
          DrawerEntities(
            text: 'CARGO COMPARTMENTS',
            function: (text) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CargoCompartments(),
              ),
            ),
          ),
          DrawerEntities(
            text: 'All holds',
            function: (text) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AllHolds(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
