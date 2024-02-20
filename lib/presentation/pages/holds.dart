import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_invoice_generator_flutter/core/have_variables.dart';
import 'package:pdf_invoice_generator_flutter/presentation/holds/add_new_hold.dart';

import '../../data/model/holds_model.dart';
import '../../data/repositories/holds_repositories.dart';
import '../widgets/drawer_navigation.dart';

class AllHolds extends StatefulWidget {
  const AllHolds({super.key});

  @override
  State<AllHolds> createState() => _AllHoldsState();
}

class _AllHoldsState extends State<AllHolds> {
  final String titleAppBar = 'All holds';

  @override
  Widget build(BuildContext context) {
    String jsonString = Hive.box(VarHave.boxHolds).get(VarHave.holds) ?? '';
    late List<HoldModel> listHolds;
    if (jsonString.isEmpty) {
      listHolds = [];
    }
    if (jsonString.isNotEmpty) {
      listHolds = HoldsRepositories().getAllHolds(jsonString);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(titleAppBar),
        ),
        drawer: const DrawerNavigation(),
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: listHolds.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddNewHold(
                            holdNumber: index + 1,
                            holdModel: listHolds[index],
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('HOLD № ${index + 1}'),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete_forever_outlined),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            TextButton(
              onPressed: () {
                HoldsRepositories().createHold();
                setState(() {});
              },
              child: const Text('Создать HOLD'),
            ),
          ],
        ),
      ),
    );
  }
}
