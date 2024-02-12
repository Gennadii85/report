import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/have_variables.dart';
import '../../core/variables_weather_decks.dart';
import '../widgets/app_bar_save_button.dart';
import '../widgets/drawer_navigation.dart';
import '../widgets/message_save.dart';
import '../widgets/picker_list.dart';
import '../widgets/table_section_watherdecks.dart';
import '../widgets/title_text.dart';

class PoopDeck extends StatefulWidget {
  const PoopDeck({super.key});
  final String titleAppBar = 'Poop deck and fittings.';

  @override
  State<PoopDeck> createState() => _PoopDeckState();
}

class _PoopDeckState extends State<PoopDeck> {
  final ImagePicker _picker = ImagePicker();
  List<String> images = Hive.box(VarHave.boxPoopDeck).get('image') ?? [];
  final Map maps = Hive.box(VarHave.boxPoopDeck).get(VarHave.table) ?? {};

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      // final imagePath = File(image.path);
      // * сохраняем только путь к файлу по адресу: "галерея/папка/файл/путь"
      List<String> save = images;
      save.add(image.path);
      Hive.box(VarHave.boxPoopDeck).put('image', save);
    });
  }

  Future checkSave(context) async {
    final Map checkTableRow = Hive.box(VarHave.boxPoopDeck).get(VarHave.table);
    if (checkTableRow.isNotEmpty) {
      Massage().saveMassage(context);
    } else {
      Massage().noSaveMassage(context);
    }
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
              function: (context) => checkSave(context),
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
                    title: VarWeather.poopDeckTitle,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 15),
                  TableSectionWatherdecks(
                    maps: maps,
                    boxName: VarHave.boxPoopDeck,
                    route: MaterialPageRoute(
                      builder: (context) => const PoopDeck(),
                    ),
                    dataList: VarWeather.dataPoopDeck,
                  ),
                  const SizedBox(height: 15),
                  images.isEmpty
                      ? const Text('Здесь могут быть фото')
                      : PickerList(
                          images: images,
                          boxName: VarHave.boxPoopDeck,
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
