import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/have_variables.dart';
import '../../data/report_service.dart';
import '../widgets/drawer_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PdfInvoiceService service = PdfInvoiceService();
  Future openAllBox() async {
    await Hive.openBox(VarHave.boxCondition);
    await Hive.openBox(VarHave.boxForwardSection);
    await Hive.openBox(VarHave.boxMiddleSection);
    await Hive.openBox(VarHave.boxAftSection);
    await Hive.openBox(VarHave.boxPortSide);
    await Hive.openBox(VarHave.boxForecastleDeck);
    await Hive.openBox(VarHave.boxStarboardSide);
    await Hive.openBox(VarHave.boxPoopDeck);
  }

  @override
  Widget build(BuildContext context) {
    openAllBox();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Victor'),
      ),
      drawer: const DrawerNavigation(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            Hive.deleteFromDisk();
                            openAllBox();
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text('Удалить'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Я передумал'),
                      ),
                    ],
                    title: const Text(
                      'Будут удалены все данные о текущем проекте.',
                    ),
                    content: const Text(
                      'Все сделанные вами ранее записи будут доступны пока приложение не будет перезапущено',
                    ),
                  );
                },
              ),
              child: const Text('Создать новый отчет'),
            ),
            ElevatedButton(
              onPressed: () async {
                final data = await service.createReport();
                service.savePdfFile("report", data);
              },
              child: const Text('Сформировать PDF файл'),
            ),
          ],
        ),
      ),
    );
  }
}
