import 'package:flutter/material.dart';
import 'package:stm/utils/appcolors.dart';
import 'package:stm/widgets/cardlistsection.dart';
import 'package:stm/widgets/chartsection.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30.0, right: 30.0, top: 40, bottom: 70),
        child: Column(
          children: [
            ChartSection(),
            Divider(
              height: 20,
              thickness: 4,
              color: RICH_BLACK_FOGRA_29,
            ),
            CardListSection(),
          ],
        ),
      ),
    );
  }
}
