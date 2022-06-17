import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/pages/utils/utils.dart';

class DescriptionField extends StatelessWidget {
  DescriptionField({
    Key? key,
    required this.descriptionFieldController,
    required this.onChange,
    required this.onTap,
  }) : super(key: key);

  VoidCallback onTap;
  TextEditingController descriptionFieldController;
  Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 64,
        child: Row(
          children: [
            const Label(text: 'Description'),
            Expanded(
              child: SizedBox(),
            ),
            GestureDetector(
              onTap: this.onTap,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                width: 48,
                height: 48,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
      TextFormField(
        controller: this.descriptionFieldController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: this.onChange,
        cursorColor: Colors.white,
        style: GoogleFonts.openSans(color: Colors.white, fontSize: 16),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.black54,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
    ]);
  }
}
