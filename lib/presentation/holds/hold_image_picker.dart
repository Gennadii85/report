// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../widgets/picker_list.dart';

class HoldPickerList extends StatelessWidget {
  const HoldPickerList({
    super.key,
    required this.imagesPath,
    required this.deleteImage,
  });
  final List<String> imagesPath;
  final Function(int index) deleteImage;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: imagesPath.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) => ImageModel(
        image: imagesPath[index],
        deleteImage: () => deleteImage(index),
      ),
    );
  }
}
