import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class card extends StatelessWidget {
  const card({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        border: Border.all(
          color: Colors.red,
          width: 3,
        ),
      ),
      child: ListTile(
        leading: Icon(
          Icons.wordpress,
          size: 20,
        ),
        title: Text(
          data.x,
          style: GoogleFonts.oswald(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          data.y.toString() + " min",
          style: GoogleFonts.openSans(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        iconColor: Colors.black,
        minLeadingWidth: 20,
      ),
    );
  }
}
