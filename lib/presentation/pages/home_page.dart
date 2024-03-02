import 'package:flutter/material.dart';
import 'package:pdf_invoice_generator_flutter/data/repositories/hive_repositories.dart';
import '../../data/pdf_ui/report_service.dart';
import '../widgets/all_section/drawer_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PdfInvoiceService service = PdfInvoiceService();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HiveRepositories().openAllBox();
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
                          HiveRepositories().deleteAllBoxValue(controller.text);

                          controller.clear();
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                        child: const Text('Создать'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Я передумал'),
                      ),
                    ],
                    title: const Text(
                      'Введите название судна',
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Будут удалены все данные о текущем проекте.',
                        ),
                      ],
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
