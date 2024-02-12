import 'package:flutter/material.dart';
import 'package:pdf_invoice_generator_flutter/presentation/pages/poop_deck.dart';
import '../pages/aft_section.dart';
import '../pages/condition.dart';
import '../pages/forecastle_deck.dart';
import '../pages/forward_section.dart';
import '../pages/home_page.dart';
import '../pages/middle_section.dart';
import '../pages/port_side.dart';
import '../pages/starboard_side.dart';
import '../pages/weather_decks.dart';

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
            function: (text) {},
          ),
          DrawerEntities(
            text: 'ENGINE ROOM',
            function: (text) {},
          ),
          DrawerEntities(
            text: 'CARGO COMPARTMENTS',
            function: (text) {},
          ),
          DrawerEntities(
            text: 'All holds',
            function: (text) {},
          ),
        ],
      ),
    );
  }
}

class DrawerEntities extends StatelessWidget {
  const DrawerEntities({
    super.key,
    required this.text,
    required this.function,
  });
  final String text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(),
          borderRadius: BorderRadius.circular(18),
        ),
        onTap: () => function(text),
        title: Text(
          text,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
