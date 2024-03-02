import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_invoice_generator_flutter/core/variables_con_for_mid_aft.dart';
import '../../core/have_variables.dart';
import '../../data/repositories/hive_repositories.dart';
import '../widgets/all_section/app_bar_save_button.dart';
import '../widgets/all_section/drawer_navigation.dart';
import '../widgets/all_section/picker_list.dart';
import '../widgets/all_section/table_section_watherdecks.dart';

class MiddleSection extends StatefulWidget {
  const MiddleSection({super.key});
  final String titleAppBar = 'Middle Section';

  @override
  State<MiddleSection> createState() => _MiddleSectionState();
}

class _MiddleSectionState extends State<MiddleSection> {
  final ImagePicker _picker = ImagePicker();
  List<String> images = Hive.box(VarHave.boxMiddleSection).get('image') ?? [];
  String dropdownValue = Hive.box(VarHave.boxMiddleSection).get('subTitle') ??
      Hive.box(VarHave.boxForwardSection).get('subTitle') ??
      VarForMidAft.subTitleListAft.first;
  final Map maps = Hive.box(VarHave.boxMiddleSection).get(VarHave.table) ?? {};

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      // final imagePath = File(image.path);
      // * сохраняем только путь к файлу по адресу: "галерея/папка/файл/путь"
      List<String> save = images;
      save.add(image.path);
      Hive.box(VarHave.boxMiddleSection).put('image', save);
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
                VarHave.boxMiddleSection,
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
                  const SizedBox(height: 15),
                  subTitle(VarHave.boxMiddleSection),
                  const SizedBox(height: 15),
                  TableSectionWatherdecks(
                    maps: maps,
                    boxName: VarHave.boxMiddleSection,
                    route: MaterialPageRoute(
                      builder: (context) => const MiddleSection(),
                    ),
                    dataList: VarTableForMidAft.dataForMidAftSection,
                  ),
                  const SizedBox(height: 15),
                  images.isEmpty
                      ? const Text('Здесь могут быть фото')
                      : PickerList(
                          images: images,
                          boxName: VarHave.boxMiddleSection,
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

  Row subTitle(String boxName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.keyboard_double_arrow_down_outlined),
          elevation: 5,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          onChanged: (value) async {
            dropdownValue = value!;
            var box = await Hive.openBox(boxName);
            box.put('subTitle', dropdownValue);
            setState(() {});
          },
          items: VarForMidAft.subTitleListMiddle
              .map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text('$value Middle Section'),
            );
          }).toList(),
        ),
      ],
    );
  }
}
