import 'package:flutter/material.dart';

class AppBarSaveButton extends StatelessWidget {
  const AppBarSaveButton({super.key, required this.function});
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: const BorderSide(),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: () => function(context),
        child: const Text(
          'SAVE',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
