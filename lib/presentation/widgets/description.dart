import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  const Description({
    super.key,
    required this.title,
    required this.function,
  });
  final String title;
  final Function function;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onDoubleTap: () => showDialog(
          context: context,
          builder: (context) {
            final TextEditingController controller =
                TextEditingController(text: widget.title);
            return ShowRenameText(
              controller: controller,
              save: (controllerText) => widget.function(controllerText),
            );
          },
        ),
        child: Text(widget.title),
      ),
    );
  }
}

class ShowRenameText extends StatelessWidget {
  ShowRenameText({
    super.key,
    required this.controller,
    required this.save,
  });

  final TextEditingController controller;
  final Function save;
  final ButtonStyle buttonStile =
      TextButton.styleFrom(backgroundColor: Colors.blue.shade50);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: TextField(
          controller: controller,
          maxLines: 50,
          onSubmitted: (value) => controller.text = value,
        ),
      ),
      actions: [
        TextButton(
          style: buttonStile,
          onPressed: () {
            save(controller.text);
            Navigator.of(context).pop();
          },
          child: const Text('SAVE'),
        ),
        TextButton(
          style: buttonStile,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL'),
        ),
      ],
    );
  }
}
