import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/have_variables.dart';
import '../../core/variables_accom_eng_cargo.dart';
import '../widgets/all_section/app_bar_save_button.dart';
import '../widgets/all_section/description_acc_eng_car.dart';
import '../widgets/all_section/drawer_navigation.dart';
import '../widgets/all_section/message_save.dart';
import '../widgets/all_section/picker_list.dart';
import '../widgets/all_section/table_section_watherdecks.dart';
import '../widgets/all_section/title_text.dart';

class CargoCompartments extends StatefulWidget {
  const CargoCompartments({super.key});
  final String titleAppBar = 'Cargo Compartments.';

  @override
  State<CargoCompartments> createState() => _CargoCompartmentsState();
}

class _CargoCompartmentsState extends State<CargoCompartments> {
  final ImagePicker _picker = ImagePicker();
  List<String> images = Hive.box(VarHave.boxAccEngCar).get(VarHave.image) ?? [];
  final Map maps = Hive.box(VarHave.boxAccEngCar).get(VarHave.table) ?? {};

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      List<String> save = images;
      save.add(image.path);
      Hive.box(VarHave.boxAccEngCar).put(VarHave.image, save);
    });
  }

  Future checkSave(context) async {
    final Map checkTableRow = Hive.box(VarHave.boxAccEngCar).get(VarHave.table);
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
                  const SizedBox(height: 30),
                  TableSectionWatherdecks(
                    maps: maps,
                    boxName: VarHave.boxAccEngCar,
                    route: MaterialPageRoute(
                      builder: (context) => const CargoCompartments(),
                    ),
                    dataList: VarAccEngCar.dataCargoCompartments,
                  ),
                  const SizedBox(height: 15),
                  images.isEmpty
                      ? const Text('Здесь могут быть фото')
                      : PickerList(
                          images: images,
                          boxName: VarHave.boxAccEngCar,
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
