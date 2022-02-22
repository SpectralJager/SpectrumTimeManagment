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
      child: Column(
        children: [
          ChartSection(),
          SizedBox(
            height: 20,
          ),
          CardListSection(),
        ],
      ),
    );
  }
}
