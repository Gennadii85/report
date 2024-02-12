import 'package:flutter/material.dart';

class Massage {
  void saveMassage(BuildContext context) {
    const snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: Text('Данные секции сохранены'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void noSaveMassage(BuildContext context) {
    const snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: Text('Сохранять пока нечего'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
