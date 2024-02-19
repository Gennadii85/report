// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pdf_invoice_generator_flutter/core/variables_holds.dart';
import 'package:pdf_invoice_generator_flutter/data/model/holds_model.dart';

import '../../core/have_variables.dart';
import '../../data/repositories/holds_repositories.dart';
import '../widgets/picker_list.dart';
import '../widgets/table_row_ui.dart';
import '../widgets/table_section_watherdecks.dart';
import 'add_new_table_row.dart';

class AddNewHold extends StatefulWidget {
  const AddNewHold({
    super.key,
    required this.holdNumber,
  });
  final int holdNumber;

  @override
  State<AddNewHold> createState() => _AddNewHoldState();
}

class _AddNewHoldState extends State<AddNewHold> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('HOLD № ${widget.holdNumber}'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HoldSectionTable(
                dataList: VarHolds.dataForwardTransverseBulkhead,
                holdNumber: widget.holdNumber,
                nameSection: VarHolds.forwardTransverseBulkheadTitle,
                tableMap: HoldsRepositories()
                    .getModel(
                      widget.holdNumber,
                      VarHolds.forwardTransverseBulkheadTitle,
                    )
                    .tableMap,
                route: MaterialPageRoute(
                  builder: (context) => AddNewHold(
                    holdNumber: widget.holdNumber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget forwardTransverseBulkhead(
    List data,
    int holdNumber,
    String nameSection,
  ) {
    final HoldSectionModel model =
        HoldsRepositories().getModel(holdNumber, nameSection);
    final List<String> images = HoldsRepositories().getImages(model);
    final ImagePicker picker = ImagePicker();
    Future getImage() async {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() {
        List<String> save = images;
        save.add(image.path);
        // HoldsRepositories().saveDada();
      });
    }

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(nameSection, style: VarHolds.titleStile),
            ),
          ],
        ),
        TableSectionWatherdecks(
          maps: model.tableMap,
          boxName: VarHave.boxHolds,
          route: MaterialPageRoute(
            builder: (context) => AddNewHold(
              holdNumber: holdNumber,
            ),
          ),
          dataList: data,
        ),
        const SizedBox(height: 15),
        images.isEmpty
            ? const Text('Здесь могут быть фото')
            : PickerList(
                images: images,
                boxName: VarHave.boxHolds,
              ),
        TextButton(
          onPressed: () => getImage(),
          child: const Text('Добавить фото'),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class HoldSectionTable extends StatefulWidget {
  const HoldSectionTable({
    super.key,
    required this.tableMap,
    required this.dataList,
    required this.holdNumber,
    required this.nameSection,
    required this.route,
  });
  final Map tableMap;
  final List dataList;
  final int holdNumber;
  final String nameSection;
  final MaterialPageRoute route;

  @override
  State<HoldSectionTable> createState() => _HoldSectionTableState();
}

class _HoldSectionTableState extends State<HoldSectionTable> {
  @override
  Widget build(BuildContext context) {
    List nameList = [];
    List valueList = [];
    widget.tableMap.forEach((key, value) {
      nameList.add(key);
      valueList.add(value);
    });

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.tableMap.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) {
            return TableRowUI(
              name: nameList[index],
              value: valueList[index],
              delete: (name) {
                widget.tableMap.remove(name);
                // Hive.box(widget.boxName).put(VarHave.table, widget.tableMap);
                setState(() {});
              },
            );
          }),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddNewTableRow(
                  boxName: VarHave.boxHolds,
                  dataList: widget.dataList,
                  route: widget.route,
                  isNoWeather: false,
                  nameHoldSection: widget.nameSection,
                  tableMap: widget.tableMap,
                ),
              ),
            );
          },
          child: const Text('Добавить строку'),
        ),
      ],
    );
  }
}
