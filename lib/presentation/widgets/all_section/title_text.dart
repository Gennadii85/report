import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.title, required this.textAlign});
  final String title;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      softWrap: true,
      maxLines: 5,
      textAlign: textAlign,
    );
  }
}
