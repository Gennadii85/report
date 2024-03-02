import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/have_variables.dart';
import '../../core/variables_accom_eng_cargo.dart';
import '../../data/repositories/hive_repositories.dart';
import '../widgets/all_section/app_bar_save_button.dart';
import '../widgets/all_section/description_acc_eng_car.dart';
import '../widgets/all_section/drawer_navigation.dart';
import '../widgets/all_section/picker_list.dart';
import '../widgets/all_section/title_text.dart';

class EngineRoom extends StatefulWidget {
  const EngineRoom({super.key});
  final String titleAppBar = 'Engine Room.';

  @override
  State<EngineRoom> createState() => _EngineRoomState();
}

class _EngineRoomState extends State<EngineRoom> {
  final ImagePicker _picker = ImagePicker();
  List<String> images =
      Hive.box(VarHave.boxAccEngCar).get(VarHave.imageEngineRoom) ?? [];
  final Map maps =
      Hive.box(VarHave.boxAccEngCar).get(VarHave.valueEngineRoom) ?? {};

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      List<String> save = images;
      save.add(image.path);
      Hive.box(VarHave.boxAccEngCar).put(VarHave.imageEngineRoom, save);
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
                VarHave.boxAccEngCar,
                VarHave.valueEngineRoom,
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
                    title: VarAccEngCar.engineRoomTitle,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 15),
                  DescriptionAccEngCar(
                    boxName: VarHave.boxAccEngCar,
                    dataList: VarAccEngCar.dataEngineRoom,
                    route: MaterialPageRoute(
                      builder: (context) => const EngineRoom(),
                    ),
                    keyBoxValue: VarHave.valueEngineRoom,
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
