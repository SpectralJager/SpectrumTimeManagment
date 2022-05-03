import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class searchField extends StatelessWidget {
  const searchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      color: Colors.black54,
      child: TextField(
        decoration: InputDecoration(
          // icon: Icon(Icons.favorite),
          labelText: 'Search',
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          helperText: 'Just enter a task name...',
          helperStyle: GoogleFonts.openSans(
            color: Colors.white70,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white30,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          filled: true,
          fillColor: Colors.black87,
          suffixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        style: GoogleFonts.openSans(
          color: Colors.white60,
        ),
      ),
    );
  }
}
