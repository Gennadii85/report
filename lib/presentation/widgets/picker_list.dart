import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PickerList extends StatefulWidget {
  const PickerList({
    super.key,
    required this.images,
    required this.boxName,
  });
  final List<String> images;
  final String boxName;

  @override
  State<PickerList> createState() => _PickerListState();
}

class _PickerListState extends State<PickerList> {
  Future deleteImage(List images, index) async {
    // List _images = await Hive.box(VarHave.boxForwardSection).get('image');
    images.removeAt(index);
    Hive.box(widget.boxName).put('image', images);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) => ImageModel(
        image: widget.images[index],
        deleteImage: () => deleteImage(widget.images, index),
      ),
    );
  }
}

class ImageModel extends StatelessWidget {
  const ImageModel({
    super.key,
    required this.image,
    required this.deleteImage,
  });
  final String image;
  final Function deleteImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  deleteImage();
                  Navigator.of(context).pop();
                },
                child: const Text('Удалить'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Я передумал'),
              ),
            ],
            title: const Text('Удалить это фото ?'),
          );
        },
      ),
      child: Image.file(
        File(image),
        fit: BoxFit.contain,
      ),
    );
  }
}
