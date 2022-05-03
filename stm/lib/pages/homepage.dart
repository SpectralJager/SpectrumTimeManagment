import 'package:flutter/material.dart';
import 'package:stm/pages/utils/gridcards.dart';
import 'package:stm/pages/utils/utils.dart';

import 'utils/calendar.dart';
import 'utils/chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
      body: bgWidget(
        bgImage: "assets/images/bg.jpg",
        overlayColor: Colors.black26,
        child: Column(
          children: [
            Calendar(),
            Divider(
              height: 2,
              thickness: 2,
              color: Colors.white,
            ),
            Chart(data: data),
            gridCards(),
          ],
        ),
      ),
    );
  }
}
