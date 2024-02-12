import 'package:flutter/material.dart';
import '../../core/variables_weather_decks.dart';
import '../widgets/drawer_navigation.dart';

class WeatherDecks extends StatelessWidget {
  const WeatherDecks({
    super.key,
    required this.titleAppBar,
  });
  final String titleAppBar;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(titleAppBar),
        ),
        drawer: const DrawerNavigation(),
        body: const Center(
          child: Text(
            'WEATHER DECKS',
            style: VarWeather.titleStile,
          ),
        ),
      ),
    );
  }
}
