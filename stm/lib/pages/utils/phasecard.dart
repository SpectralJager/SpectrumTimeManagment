import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/models/phase.dart';

class PhaseCard extends StatelessWidget {
  const PhaseCard({
    Key? key,
    required this.phase,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.onDismissed,
  }) : super(key: key);

  final Phase phase;
  final int index;
  final String title;
  final String subtitle;
  final Function onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<Phase>(phase),
      // background: Container(
      //   color: Colors.red,
      // ),
      onDismissed: (_) {
        this.onDismissed();
      },
      child: Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '# ' + (index).toString(),
                  style: GoogleFonts.oswald(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 5,
                  height: 40,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.redAccent,
                ),
                Text(
                  title,
                  style: GoogleFonts.oswald(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.timer,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
