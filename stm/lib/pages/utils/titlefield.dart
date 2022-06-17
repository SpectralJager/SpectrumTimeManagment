import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/pages/utils/utils.dart';

class TitleField extends StatelessWidget {
  TitleField({
    Key? key,
    required this.nameFieldController,
    required this.onChange,
    required this.onTapClear,
  }) : super(key: key);

  TextEditingController nameFieldController;
  Function(String) onChange;
  VoidCallback onTapClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        const Label(text: 'Title'),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 64,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: this.nameFieldController,
                  onChanged: this.onChange,
                  cursorColor: Colors.white,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 16),
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
              ),
              GestureDetector(
                onTap: this.onTapClear,
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
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
      ],
    );
  }
}
