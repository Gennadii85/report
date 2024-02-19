import 'package:flutter/material.dart';
import 'package:pdf_invoice_generator_flutter/presentation/pages/add_new_hold.dart';

import '../widgets/drawer_navigation.dart';

class AllHolds extends StatelessWidget {
  const AllHolds({super.key});
  final String titleAppBar = 'All holds';

  @override
  Widget build(BuildContext context) {
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
              itemCount: 7,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddNewHold(
                            holdNumber: index + 1,
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
          ],
        ),
      ),
    );
  }
}
