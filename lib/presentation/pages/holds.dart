// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pdf_invoice_generator_flutter/core/have_variables.dart';
import 'package:pdf_invoice_generator_flutter/entities/hold_entities.dart';
import 'package:pdf_invoice_generator_flutter/presentation/holds/add_new_hold.dart';

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
    List listHolds = Hive.box(VarHave.boxHolds).get(VarHave.holds) ?? [];
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
                return AllHoldRow(
                  name: 'HOLD ${index + 1}',
                  delete: () {
                    HoldsRepositories().deleteHold(index);
                    setState(() {});
                  },
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

class AllHoldRow extends StatelessWidget {
  final String name;
  final Function delete;
  const AllHoldRow({
    super.key,
    required this.name,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
      child: InkWell(
        onTap: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => AddNewHold(
          //       holdNumber: index + 1,
          //       holdModel: [],
          //     ),
          //   ),
          // );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
            IconButton(
              onPressed: () => delete(),
              icon: const Icon(Icons.delete_forever_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
