import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/have_variables.dart';
import '../../core/variables_weather_decks.dart';
import '../../data/repositories/hive_repositories.dart';
import '../widgets/all_section/app_bar_save_button.dart';
import '../widgets/all_section/drawer_navigation.dart';
import '../widgets/all_section/picker_list.dart';
import '../widgets/all_section/table_section_watherdecks.dart';
import '../widgets/all_section/title_text.dart';

class ForecastleDeck extends StatefulWidget {
  const ForecastleDeck({super.key});
  final String titleAppBar = 'Forecastle deck and fittings.';

  @override
  State<ForecastleDeck> createState() => _ForecastleDeckState();
}

class _ForecastleDeckState extends State<ForecastleDeck> {
  final ImagePicker _picker = ImagePicker();
  List<String> images = Hive.box(VarHave.boxForecastleDeck).get('image') ?? [];
  final Map maps = Hive.box(VarHave.boxForecastleDeck).get(VarHave.table) ?? {};

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      // final imagePath = File(image.path);
      // * сохраняем только путь к файлу по адресу: "галерея/папка/файл/путь"
      List<String> save = images;
      save.add(image.path);
      Hive.box(VarHave.boxForecastleDeck).put('image', save);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.titleAppBar),
          actions: [
            AppBarSaveButton(
              function: (context) => HiveRepositories().checkSave(
                context,
                VarHave.boxForecastleDeck,
                VarHave.table,
              ),
            ),
          ],
        ),
        drawer: const DrawerNavigation(),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const TitleText(
                    title: VarWeather.forecastleDeckTitle,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 15),
                  TableSectionWatherdecks(
                    maps: maps,
                    boxName: VarHave.boxForecastleDeck,
                    route: MaterialPageRoute(
                      builder: (context) => const ForecastleDeck(),
                    ),
                    dataList: VarWeather.dataForecastleDeck,
                  ),
                  const SizedBox(height: 15),
                  images.isEmpty
                      ? const Text('Здесь могут быть фото')
                      : PickerList(
                          images: images,
                          boxName: VarHave.boxPortSide,
                        ),
                  TextButton(
                    onPressed: () => getImage(),
                    child: const Text('Добавить фото'),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
