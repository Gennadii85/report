import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_invoice_generator_flutter/core/variables_con_for_mid_aft.dart';
import '../../core/have_variables.dart';
import '../cubit/aft_section/aft_table_cubit.dart';
import '../widgets/app_bar_save_button.dart';
import '../widgets/drawer_navigation.dart';
import '../widgets/picker_list.dart';

class AftSection extends StatefulWidget {
  const AftSection({super.key, required this.titleAppBar});
  final String titleAppBar;

  @override
  State<AftSection> createState() => _AftSectionState();
}

class _AftSectionState extends State<AftSection> {
  final ImagePicker _picker = ImagePicker();
  List<String> images = Hive.box(VarHave.boxAftSection).get('image') ?? [];
  String dropdownValue = Hive.box(VarHave.boxForwardSection).get('subTitle') ??
      VarForMidAft.subTitleListAft.first;

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.titleAppBar),
          actions: [
            AppBarSaveButton(
              function: (context) {
                BlocProvider.of<TableCubitAft>(context).saveAftSection(
                  VarHave.boxAftSection,
                  context,
                  dropdownValue,
                );
              },
            ),
          ],
        ),
        drawer: const DrawerNavigation(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 15),
                subTitle(),
                const SizedBox(height: 10),
                const TableSectionMiddle(),
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
    );
  }

  Row subTitle() {
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
            Hive.box(VarHave.boxMiddleSection).put('subTitle', value);
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

class TableSectionMiddle extends StatelessWidget {
  const TableSectionMiddle({super.key});
  final String name1 = 'Coating:';
  final String name2 = 'Plating structure:';
  final String name3 = 'Draft marks:';

  @override
  Widget build(BuildContext context) {
    final tableCubit = BlocProvider.of<TableCubitAft>(context);

    return BlocBuilder<TableCubitAft, TableStateAft>(
      builder: (context, state) {
        return Table(
          border: TableBorder.all(color: Colors.black),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(3),
          },
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(name1),
                ),
                Column(
                  children: [
                    DropdownMenu<String>(
                      initialSelection: state.param1,
                      dropdownMenuEntries: VarTableForMidAft.coatingListItems,
                      onSelected: (value) {
                        state.param1 = value!;
                        tableCubit.updateParameters(
                          value,
                          state.param2,
                          state.param3,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onDoubleTap: () => showDialog(
                          context: context,
                          builder: (context) {
                            final TextEditingController controller =
                                TextEditingController(text: state.param1);
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: TextField(
                                  controller: controller,
                                  maxLines: 25,
                                  onSubmitted: (value) =>
                                      controller.text = value,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue.shade50,
                                  ),
                                  onPressed: () {
                                    tableCubit.updateParameters(
                                      controller.text,
                                      state.param2,
                                      state.param3,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('SAVE'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue.shade50,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('CANCEL'),
                                ),
                              ],
                            );
                          },
                        ),
                        child: Text(state.param1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(name2),
                ),
                Column(
                  children: [
                    DropdownMenu<String>(
                      initialSelection: state.param2,
                      dropdownMenuEntries: VarTableForMidAft.platingListItems,
                      onSelected: (value) {
                        state.param2 = value!;
                        tableCubit.updateParameters(
                          state.param1,
                          value,
                          state.param3,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onDoubleTap: () => showDialog(
                          context: context,
                          builder: (context) {
                            final TextEditingController controller =
                                TextEditingController(text: state.param2);
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: TextField(
                                  controller: controller,
                                  maxLines: 30,
                                  onSubmitted: (value) =>
                                      controller.text = value,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue.shade50,
                                  ),
                                  onPressed: () {
                                    tableCubit.updateParameters(
                                      state.param1,
                                      controller.text,
                                      state.param3,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('SAVE'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue.shade50,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('CANCEL'),
                                ),
                              ],
                            );
                          },
                        ),
                        child: Text(state.param2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(name3),
                ),
                Column(
                  children: [
                    DropdownMenu<String>(
                      initialSelection: state.param3,
                      dropdownMenuEntries: VarTableForMidAft.draftListItems,
                      onSelected: (value) {
                        state.param3 = value!;
                        tableCubit.updateParameters(
                          state.param1,
                          state.param2,
                          value,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onDoubleTap: () => showDialog(
                          context: context,
                          builder: (context) {
                            final TextEditingController controller =
                                TextEditingController(text: state.param3);
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: TextField(
                                  controller: controller,
                                  maxLines: 30,
                                  onSubmitted: (value) =>
                                      controller.text = value,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue.shade50,
                                  ),
                                  onPressed: () {
                                    tableCubit.updateParameters(
                                      state.param1,
                                      state.param2,
                                      controller.text,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('SAVE'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue.shade50,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('CANCEL'),
                                ),
                              ],
                            );
                          },
                        ),
                        child: Text(state.param3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
