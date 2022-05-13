import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:stm/pages/utils/utils.dart';

class ColorField extends StatelessWidget {
  final color;
  Function(Color) onColorChanged;

  ColorField({Key? key, required this.color, required this.onColorChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Label(text: 'Color'),
            Expanded(child: SizedBox()),
            Container(
              margin: EdgeInsets.only(left: 20, right: 10),
              width: 128,
              height: 32,
              decoration: BoxDecoration(
                color: this.color,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.defaultDialog(
                  title: 'Select Color',
                  content: ColorPicker(
                    pickerColor: this.color,
                    onColorChanged: this.onColorChanged,
                  ),
                );
              },
              child: Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
