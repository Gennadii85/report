import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_invoice_generator_flutter/core/variables_vessels.dart';
import 'package:pdf_invoice_generator_flutter/data/repositories/hive_repositories.dart';

import '../../core/have_variables.dart';
import '../widgets/all_section/app_bar_save_button.dart';
import '../widgets/all_section/description_acc_eng_car.dart';
import '../widgets/all_section/drawer_navigation.dart';
import '../widgets/all_section/picker_list.dart';
import '../widgets/all_section/table_section_watherdecks.dart';
import '../widgets/all_section/title_text.dart';

class VesselsWeatherDeck extends StatefulWidget {
  final String titleAppBar = 'THE VESSELS WEATHER DECK OPENINGS:';
  const VesselsWeatherDeck({super.key});

  @override
  State<VesselsWeatherDeck> createState() => _VesselsWeatherDeckState();
}

class _VesselsWeatherDeckState extends State<VesselsWeatherDeck> {
  final ImagePicker _picker = ImagePicker();
  List<String> images = Hive.box(VarHave.boxVessels).get(VarHave.image) ?? [];
  final Map maps = Hive.box(VarHave.boxVessels).get(VarHave.table) ?? {};

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      List<String> save = images;
      save.add(image.path);
      Hive.box(VarHave.boxVessels).put(VarHave.image, save);
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
                VarHave.boxVessels,
                VarHave.valueVesselsWeatherDeck,
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
                    title: VarVessels.vesselsTitle,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 15),
                  DescriptionAccEngCar(
                    boxName: VarHave.boxVessels,
                    dataList: VarVessels.dataDescriptionVessels,
                    route: MaterialPageRoute(
                      builder: (context) => const VesselsWeatherDeck(),
                    ),
                    keyBoxValue: VarHave.valueVesselsWeatherDeck,
                  ),
                  const SizedBox(height: 15),
                  TableSectionWatherdecks(
                    maps: maps,
                    boxName: VarHave.boxVessels,
                    route: MaterialPageRoute(
                      builder: (context) => const VesselsWeatherDeck(),
                    ),
                    dataList: VarVessels.dataTableVessels,
                  ),
                  const SizedBox(height: 15),
                  images.isEmpty
                      ? const Text('Здесь могут быть фото')
                      : PickerList(
                          images: images,
                          boxName: VarHave.boxVessels,
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
