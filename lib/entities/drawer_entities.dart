import 'package:flutter/material.dart';

class DrawerEntities extends StatelessWidget {
  const DrawerEntities({
    super.key,
    required this.text,
    required this.function,
  });
  final String text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(),
          borderRadius: BorderRadius.circular(18),
        ),
        onTap: () => function(text),
        title: Text(
          text,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
