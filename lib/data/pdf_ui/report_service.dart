import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf_invoice_generator_flutter/core/variables_holds.dart';
import '../../core/have_variables.dart';
import '../../core/variables_accom_eng_cargo.dart';
import '../../core/variables_weather_decks.dart';

class PdfInvoiceService {
  PageTheme pageTheme = const PageTheme(pageFormat: PdfPageFormat.a4);

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
    Uint8List logo =
        (await rootBundle.load('assets/logo.jpg')).buffer.asUint8List();
    final String boatName =
        Hive.box(VarHave.boxCondition).get(VarHave.boatName);
    //! Condition
    var condition = Hive.box(VarHave.boxCondition);
    //! Forward Section
    var boxForwardSection = Hive.box(VarHave.boxForwardSection);
    final Map forwardSectionMap = boxForwardSection.get(VarHave.table) ?? {};
    final List<String> forwardImages = boxForwardSection.get('image') ?? [];
    final List<Uint8List> forwardPages = await getImageList(forwardImages);

    //! Middle Section
    var boxMiddleSection = Hive.box(VarHave.boxMiddleSection);
    final Map middleSectionMap = boxMiddleSection.get(VarHave.table) ?? {};
    final List<String> middleImages = boxMiddleSection.get('image') ?? [];
    final List<Uint8List> middlePages = await getImageList(middleImages);

    //! Aft Section
    var boxAftSection = Hive.box(VarHave.boxAftSection);
    final Map aftSectionMap = boxAftSection.get(VarHave.table) ?? {};
    final List<String> aftImages = boxAftSection.get('image') ?? [];
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
        Hive.box(VarHave.boxAccEngCar).get(VarHave.valueAccommodation) ?? {};
    String accommodationValue = '';

    if (accommodationMap.isEmpty) {
      accommodationValue = '';
    } else {
      accommodationValue = accommodationMap.entries.first.value.toString();
    }
    final List<String> accommodationImages =
        Hive.box(VarHave.boxAccEngCar).get(VarHave.imageAccommodation) ?? [];
    final List<Uint8List> accommodationPages =
        await getImageList(accommodationImages);

    //! ENGINE ROOM
    final Map engineRoomMap =
        Hive.box(VarHave.boxAccEngCar).get(VarHave.valueEngineRoom) ?? {};
    String engineRoomValue = '';
    if (engineRoomMap.isEmpty) {
      engineRoomValue = '';
    } else {
      engineRoomValue = engineRoomMap.entries.first.value.toString();
    }
    final List<String> engineRoomImages =
        Hive.box(VarHave.boxAccEngCar).get(VarHave.imageEngineRoom) ?? [];
    final List<Uint8List> engineRoomPages =
        await getImageList(engineRoomImages);

    //! CARGO COMPARTMENTS
    final Map cargoCompartmentsMap =
        Hive.box(VarHave.boxAccEngCar).get(VarHave.table) ?? {};
    String cargoCompartmentsTitle = '';
    if (cargoCompartmentsMap.isEmpty) {
      cargoCompartmentsTitle = '';
    } else {
      cargoCompartmentsTitle = VarAccEngCar.cargoCompartmentsTitle;
    }
    final List<String> cargoCompartmentsImages =
        Hive.box(VarHave.boxAccEngCar).get(VarHave.image) ?? [];
    final List<Uint8List> cargoCompartmentsPages =
        await getImageList(cargoCompartmentsImages);

    //! HOLDS
    final List allHolds = Hive.box(VarHave.boxHolds).get(VarHave.holds) ?? [];
    List<Widget> listHolds = [];

    final pdf = Document();
    pdf.addPage(
      MultiPage(
        maxPages: 100,
        pageTheme: pageTheme,
        footer: (context) => Row(
          children: [
            Spacer(),
            Text('survey@fdi.ltd - your fair detective investigators'),
            Spacer(),
            Text(context.pageNumber.toString()),
          ],
        ),
        header: (context) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(MemoryImage(logo), width: 130, height: 35),
                Text('MV ${boatName.toUpperCase()} ON-HIRE REPORT'),
              ],
            ),
            sizedBox15(),
          ],
        ),
        build: (context) {
          return [
            conditionPDF(condition, hederStile),
            sizedBox15(),
            //!  Forward Section
            tableSectionForwardMiddleAftPDF(
              forwardSectionMap,
              boxForwardSection,
              hederStile,
              'Forward Section',
            ),
            sizedBox15(),
            imagesSectionPDF(forwardPages, pageTheme),
            sizedBox15(),
            //!  Middle Section
            tableSectionForwardMiddleAftPDF(
              middleSectionMap,
              boxMiddleSection,
              hederStile,
              'Middle Section',
            ),
            imagesSectionPDF(middlePages, pageTheme),
            sizedBox15(),
            //!  Aft Section
            tableSectionForwardMiddleAftPDF(
              aftSectionMap,
              boxAftSection,
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
              portSideMap,
              hederStile,
              VarWeather.portSideTitle,
            ),
            imagesSectionPDF(portSidePages, pageTheme),
            sizedBox15(),
            //! Forecastle Deck
            weatherDecksTable(
              forecastleDeckMap,
              hederStile,
              VarWeather.forecastleDeckTitle,
            ),
            imagesSectionPDF(forecastleDeckPages, pageTheme),
            sizedBox15(),
            //! StarboardSide
            weatherDecksTable(
              starboardSideMap,
              hederStile,
              VarWeather.starboardSideTitle,
            ),
            imagesSectionPDF(starboardSidePages, pageTheme),
            sizedBox15(),
            //! Poop Deck
            weatherDecksTable(
              poopDeckMap,
              hederStile,
              VarWeather.poopDeckTitle,
            ),
            imagesSectionPDF(poopDeckPages, pageTheme),
            sizedBox15(),
            //! ACCOMMODATION
            varAccEngCarDescription(
              VarAccEngCar.accommodationTitle,
              hederStile,
              accommodationValue,
            ),
            imagesSectionPDF(accommodationPages, pageTheme),
            sizedBox15(),
            //! ENGINE ROOM
            varAccEngCarDescription(
              VarAccEngCar.engineRoomTitle,
              hederStile,
              engineRoomValue,
            ),
            imagesSectionPDF(engineRoomPages, pageTheme),
            sizedBox15(),
            //! CARGO COMPARTMENTS
            weatherDecksTable(
              cargoCompartmentsMap,
              hederStile,
              cargoCompartmentsTitle,
            ),
            imagesSectionPDF(cargoCompartmentsPages, pageTheme),
            sizedBox15(),
            //! HOLDS
            ListView(children: listHolds),
          ];
        },
      ),
    );

    for (var element in allHolds) {
      int indexHold = allHolds.indexOf(element);
      final List<Uint8List> forwardPagesHold =
          await getImageList(element.listImagePathForward);
      final List<Uint8List> starboardPagesHold =
          await getImageList(element.listImagePathStarboard);
      final List<Uint8List> aftPagesHold =
          await getImageList(element.listImagePathAft);
      final List<Uint8List> portPagesHold =
          await getImageList(element.listImagePathPort);
      final List<Uint8List> tankPagesHold =
          await getImageList(element.listImagePathTank);
      listHolds.addAll(
        [
          holdName(indexHold, hederStile),
          sizedBox15(),
          //Forward transverse bulkhead
          weatherDecksTable(
            element.tableMapForward,
            hederStile,
            VarHolds.forwardTransverseBulkheadTitle,
          ),
          imagesSectionPDF(forwardPagesHold, pageTheme),
          sizedBox15(),
          //Starboard ship’s side
          weatherDecksTable(
            element.tableMapStarboard,
            hederStile,
            VarHolds.starboardShipsSideTitle,
          ),
          imagesSectionPDF(starboardPagesHold, pageTheme),
          sizedBox15(),
          //Aft transverse bulkhead
          weatherDecksTable(
            element.tableMapAft,
            hederStile,
            VarHolds.aftTransverseBulkheadTitle,
          ),
          imagesSectionPDF(aftPagesHold, pageTheme),
          sizedBox15(),
          //Port ship’s side
          weatherDecksTable(
            element.tableMapPort,
            hederStile,
            VarHolds.portShipsSideTitle,
          ),
          imagesSectionPDF(portPagesHold, pageTheme),
          sizedBox15(),
          //Tank tops
          weatherDecksTable(
            element.tableMapTank,
            hederStile,
            VarHolds.tankTopsTitle,
          ),
          imagesSectionPDF(tankPagesHold, pageTheme),
          sizedBox15(),
        ],
      );
      pdf.addPage(
        MultiPage(
          maxPages: 50,
          pageTheme: pageTheme,
          footer: (context) => Row(
            children: [
              Spacer(),
              Text('survey@fdi.ltd - your fair detective investigators'),
              Spacer(),
              Text(context.pageNumber.toString()),
            ],
          ),
          header: (context) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(MemoryImage(logo), width: 130, height: 35),
                  Text('MV ${boatName.toUpperCase()} ON-HIRE REPORT'),
                ],
              ),
              sizedBox15(),
            ],
          ),
          build: (context) {
            return listHolds;
          },
        ),
      );
      listHolds.clear();
    }

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
    Box box,
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
              '${box.get('subTitle') ?? ''}$nameSection',
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

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title, style: hederStile),
          ],
        ),
        SizedBox(height: 10),
        ...tableList,
      ],
    );
  }

  Widget varAccEngCarDescription(
    String title,
    TextStyle hederStile,
    String value,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text(title, style: hederStile)],
        ),
        SizedBox(height: 15),
        Text(value),
      ],
    );
  }

  Widget holdName(int index, hederStile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'HOLD No. ${index + 1}',
          style: hederStile,
        ),
      ],
    );
  }
}
