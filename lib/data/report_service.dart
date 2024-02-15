// ignore_for_file: require_trailing_commas

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../core/have_variables.dart';
import '../core/variables_weather_decks.dart';

class PdfInvoiceService {
  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    //* final output = await getTemporaryDirectory(); это для IOS
    final output = await getTemporaryDirectory(); //* это под Android
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    // await OpenDocument.openDocument(filePath: filePath);
  }

  Future<Uint8List> createReport() async {
    //* await getTemporaryDirectory();
    await getTemporaryDirectory(); //* это под Android
    TextStyle hederStile = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
    //! Condition
    var condition = Hive.box(VarHave.boxCondition);
    //! Forward Section
    var forwardSection = Hive.box(VarHave.boxForwardSection);
    final Map forwardSectionMap = forwardSection.get(VarHave.table) ?? {};
    final List<String> forwardImages = forwardSection.get('image') ?? [];
    final List<Uint8List> forwardPages = [];
    for (var element in forwardImages) {
      Uint8List imageData =
          (await rootBundle.load(element)).buffer.asUint8List();
      forwardPages.add(imageData);
    }
    //! Middle Section
    var middleSection = Hive.box(VarHave.boxMiddleSection);
    final Map middleSectionMap = middleSection.get(VarHave.table) ?? {};
    final List<String> middleImages = middleSection.get('image') ?? [];
    final List<Uint8List> middlePages = [];
    for (var element in middleImages) {
      Uint8List imageData =
          (await rootBundle.load(element)).buffer.asUint8List();
      middlePages.add(imageData);
    }
    print(middlePages);

    //! Aft Section
    var aftSection = Hive.box(VarHave.boxAftSection);
    final Map aftSectionMap = aftSection.get(VarHave.table) ?? {};
    final List<String> aftImages = aftSection.get('image') ?? [];
    final List<Uint8List> aftPages = [];
    for (var element in aftImages) {
      Uint8List imageData =
          (await rootBundle.load(element)).buffer.asUint8List();
      aftPages.add(imageData);
    }

    //! Port Side
    var boxPortSide = Hive.box(VarHave.boxPortSide);
    final Map portSideMap = boxPortSide.get(VarHave.table) ?? {};
    final List<String> portSideImages = boxPortSide.get(VarHave.image) ?? [];
    final List<Uint8List> portSidePages = [];
    for (var element in portSideImages) {
      Uint8List imageData =
          (await rootBundle.load(element)).buffer.asUint8List();
      portSidePages.add(imageData);
    }

    final pdf = Document();
    const pageTheme = PageTheme(pageFormat: PdfPageFormat.a4);
    pdf.addPage(
      MultiPage(
        pageTheme: pageTheme,
        build: (context) {
          return [
            conditionPDF(condition, hederStile),
            sizedBox15(),
            //!  Forward Section
            tableSectionForwardMiddleAftPDF(
              forwardSectionMap,
              forwardSection,
              hederStile,
              'Forward Section',
            ),
            sizedBox15(),
            imagesSectionPDF(forwardPages, pageTheme),
            sizedBox15(),
            //!  Middle Section
            tableSectionForwardMiddleAftPDF(
              middleSectionMap,
              middleSection,
              hederStile,
              'Middle Section',
            ),
            imagesSectionPDF(middlePages, pageTheme),
            sizedBox15(),
            //!  Aft Section
            tableSectionForwardMiddleAftPDF(
              aftSectionMap,
              aftSection,
              hederStile,
              'Aft Section',
            ),
            imagesSectionPDF(aftPages, pageTheme),
            sizedBox15(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'WEATHER DECKS',
                  style: hederStile,
                ),
              ],
            ),
            sizedBox15(),
            //! Port Side
            weatherDecksTable(
                portSideMap, hederStile, VarWeather.portSideTitle),
            imagesSectionPDF(portSidePages, pageTheme),
          ];
        },
      ),
    );
    return pdf.save();
  }

  Widget sizedBox15() {
    return SizedBox(height: 15);
  }

  Widget conditionPDF(condition, hederStile) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              condition.get('title') ?? '',
              style: hederStile,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SPECIFIC DAMAGES AND DEFECTS NOTED ON BOARD',
              style: hederStile,
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'OUTER SHELL PLATING',
              style: hederStile,
            ),
          ],
        ),
        Text(condition.get('description') ?? ''),
      ],
    );
  }

  Widget tableSectionForwardMiddleAftPDF(
    Map map,
    forwardSection,
    hederStile,
    String nameSection,
  ) {
    List<Table> tableList = [];
    map.forEach((key, value) {
      final oneTableRow = Table(
        border: TableBorder.all(),
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
                child: Text(key.toString()),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(value.toString()),
              ),
            ],
          ),
        ],
      );
      tableList.add(oneTableRow);
    });
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${forwardSection.get('subTitle') ?? ''}$nameSection',
              style: hederStile,
            ),
          ],
        ),
        SizedBox(height: 15),
        ...tableList,
      ],
    );
  }

  Widget imagesSectionPDF(List<Uint8List> pages, pageTheme) {
    List<Widget> pic = pages
        .map(
          (e) => Image(
            MemoryImage(e),
            width: pageTheme.pageFormat.availableWidth / 2,
          ),
        )
        .toList();
    return GridView(
      crossAxisCount: 2,
      crossAxisSpacing: 20.0,
      mainAxisSpacing: -30.0,
      childAspectRatio: 1,
      children: pic,
    );
  }

  Widget weatherDecksTable(Map map, hederStile, title) {
    List<Table> tableList = [];
    map.forEach((key, value) {
      final oneTableRow = Table(
        border: TableBorder.all(),
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
                child: Text(key.toString()),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(value.toString()),
              ),
            ],
          ),
        ],
      );
      tableList.add(oneTableRow);
    });

    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: hederStile),
        ],
      ),
      SizedBox(height: 15),
      ...tableList,
    ]);
  }
}
