import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_invoice_generator_flutter/core/variables_con_for_mid_aft.dart';
import '../../core/have_variables.dart';
import '../widgets/all_section/app_bar_save_button.dart';
import '../widgets/all_section/drawer_navigation.dart';
import '../widgets/all_section/message_save.dart';
import '../widgets/all_section/picker_list.dart';
import '../widgets/all_section/table_section_watherdecks.dart';

class AftSection extends StatefulWidget {
  const AftSection({super.key});
  final String titleAppBar = 'Aft Section';

  @override
  State<AftSection> createState() => _AftSectionState();
}

class _AftSectionState extends State<AftSection> {
  final ImagePicker _picker = ImagePicker();
  List<String> images = Hive.box(VarHave.boxAftSection).get('image') ?? [];
  String dropdownValue = Hive.box(VarHave.boxAftSection).get('subTitle') ??
      Hive.box(VarHave.boxForwardSection).get('subTitle') ??
      VarForMidAft.subTitleListAft.first;
  final Map maps = Hive.box(VarHave.boxAftSection).get(VarHave.table) ?? {};

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      // final imagePath = File(image.path);
      // * сохраняем только путь к файлу по адресу: "галерея/папка/файл/путь"
      List<String> save = images;
      save.add(image.path);
      Hive.box(VarHave.boxAftSection).put('image', save);
    });
  }

  Future checkSave(context) async {
    final Map checkTableRow =
        Hive.box(VarHave.boxAftSection).get(VarHave.table);
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
                  const SizedBox(height: 15),
                  subTitle(VarHave.boxAftSection),
                  const SizedBox(height: 15),
                  TableSectionWatherdecks(
                    maps: maps,
                    boxName: VarHave.boxAftSection,
                    route: MaterialPageRoute(
                      builder: (context) => const AftSection(),
                    ),
                    dataList: VarTableForMidAft.dataForMidAftSection,
                  ),
                  const SizedBox(height: 15),
                  images.isEmpty
                      ? const Text('Здесь могут быть фото')
                      : PickerList(
                          images: images,
                          boxName: VarHave.boxAftSection,
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
          items: VarForMidAft.subTitleListAft
              .map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text('$value Aft Section'),
            );
          }).toList(),
        ),
      ],
    );
  }
}
