// ignore_for_file: require_trailing_commas

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../core/have_variables.dart';
import '../core/variables_accom_eng_cargo.dart';
import '../core/variables_weather_decks.dart';

class PdfInvoiceService {
  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory(); //* это под Android и для IOS
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }

  Future<List<Uint8List>> getImageList(List<String> images) async {
    List<Uint8List> sectionPages = [];
    for (var element in images) {
      File file = File(element);
      Uint8List fileBytes = await file.readAsBytes();
      ByteData data = fileBytes.buffer.asByteData();
      Uint8List bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Uint8List imageData = (await rootBundle.load(file)).buffer.asUint8List();
      sectionPages.add(bytes);
    }
    return sectionPages;
  }

  Future<Uint8List> createReport() async {
    await getTemporaryDirectory(); //* это под Android и для IOS
    TextStyle hederStile = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
    //! Condition
    var condition = Hive.box(VarHave.boxCondition);
    //! Forward Section
    var forwardSection = Hive.box(VarHave.boxForwardSection);
    final Map forwardSectionMap = forwardSection.get(VarHave.table) ?? {};
    final List<String> forwardImages = forwardSection.get('image') ?? [];
    final List<Uint8List> forwardPages = await getImageList(forwardImages);

    //! Middle Section
    var middleSection = Hive.box(VarHave.boxMiddleSection);
    final Map middleSectionMap = middleSection.get(VarHave.table) ?? {};
    final List<String> middleImages = middleSection.get('image') ?? [];
    final List<Uint8List> middlePages = await getImageList(middleImages);

    //! Aft Section
    var aftSection = Hive.box(VarHave.boxAftSection);
    final Map aftSectionMap = aftSection.get(VarHave.table) ?? {};
    final List<String> aftImages = aftSection.get('image') ?? [];
    final List<Uint8List> aftPages = await getImageList(aftImages);

    //! Port Side
    var boxPortSide = Hive.box(VarHave.boxPortSide);
    final Map portSideMap = boxPortSide.get(VarHave.table) ?? {};
    final List<String> portSideImages = boxPortSide.get(VarHave.image) ?? [];
    final List<Uint8List> portSidePages = await getImageList(portSideImages);

    //! Forecastle Deck
    var boxForecastleDeck = Hive.box(VarHave.boxForecastleDeck);
    final Map forecastleDeckMap = boxForecastleDeck.get(VarHave.table) ?? {};
    final List<String> forecastleDeckImages =
        boxForecastleDeck.get(VarHave.image) ?? [];
    final List<Uint8List> forecastleDeckPages =
        await getImageList(forecastleDeckImages);

    //! StarboardSide
    var boxStarboardSide = Hive.box(VarHave.boxStarboardSide);
    final Map starboardSideMap = boxStarboardSide.get(VarHave.table) ?? {};
    final List<String> starboardSideImages =
        boxStarboardSide.get(VarHave.image) ?? [];
    final List<Uint8List> starboardSidePages =
        await getImageList(starboardSideImages);

    //! Poop Deck
    var boxPoopDeck = Hive.box(VarHave.boxPoopDeck);
    final Map poopDeckMap = boxPoopDeck.get(VarHave.table) ?? {};
    final List<String> poopDeckImages = boxPoopDeck.get(VarHave.image) ?? [];
    final List<Uint8List> poopDeckPages = await getImageList(poopDeckImages);

    //! ACCOMMODATION
    final Map accommodationMap =
        Hive.box(VarHave.boxAccEngCar).get(VarHave.valueAccommodation);
    final String accommodationValue =
        accommodationMap.entries.first.value.toString();
    final List<String> accommodationImages =
        Hive.box(VarHave.boxAccEngCar).get(VarHave.imageAccommodation) ?? [];
    final List<Uint8List> accommodationPages =
        await getImageList(accommodationImages);

    //! ENGINE ROOM
    final Map engineRoomMap =
        Hive.box(VarHave.boxAccEngCar).get(VarHave.valueEngineRoom);
    final String engineRoomValue = engineRoomMap.entries.first.value.toString();
    final List<String> engineRoomImages =
        Hive.box(VarHave.boxAccEngCar).get(VarHave.imageEngineRoom) ?? [];
    final List<Uint8List> engineRoomPages =
        await getImageList(engineRoomImages);

    //! CARGO COMPARTMENTS
    final Map cargoCompartmentsMap =
        Hive.box(VarHave.boxAccEngCar).get(VarHave.valueCargoCompartments);
    final String cargoCompartmentsValue =
        cargoCompartmentsMap.entries.first.value.toString();
    final List<String> cargoCompartmentsImages =
        Hive.box(VarHave.boxAccEngCar).get(VarHave.imageCargoCompartments) ??
            [];
    final List<Uint8List> cargoCompartmentsPages =
        await getImageList(cargoCompartmentsImages);

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
            sizedBox15(),
            //! Forecastle Deck
            weatherDecksTable(
                forecastleDeckMap, hederStile, VarWeather.forecastleDeckTitle),
            imagesSectionPDF(forecastleDeckPages, pageTheme),
            sizedBox15(),
            //! StarboardSide
            weatherDecksTable(
                starboardSideMap, hederStile, VarWeather.starboardSideTitle),
            imagesSectionPDF(starboardSidePages, pageTheme),
            sizedBox15(),
            //! Poop Deck
            weatherDecksTable(
                poopDeckMap, hederStile, VarWeather.poopDeckTitle),
            imagesSectionPDF(poopDeckPages, pageTheme),
            sizedBox15(),
            //! ACCOMMODATION
            varAccEngCarDescription(VarAccEngCar.accommodationTitle, hederStile,
                accommodationValue),
            imagesSectionPDF(accommodationPages, pageTheme),
            sizedBox15(),
            //! ENGINE ROOM
            varAccEngCarDescription(
                VarAccEngCar.engineRoomTitle, hederStile, engineRoomValue),
            imagesSectionPDF(engineRoomPages, pageTheme),
            sizedBox15(),
            //! CARGO COMPARTMENTS
            varAccEngCarDescription(VarAccEngCar.cargoCompartmentsTitle,
                hederStile, cargoCompartmentsValue),
            imagesSectionPDF(cargoCompartmentsPages, pageTheme),
            sizedBox15(),
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

  Widget varAccEngCarDescription(
      String title, TextStyle hederStile, String value) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Text(title, style: hederStile)],
      ),
      SizedBox(height: 15),
      Text(value)
    ]);
  }
}
