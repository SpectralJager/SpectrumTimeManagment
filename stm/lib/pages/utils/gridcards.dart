import 'package:flutter/material.dart';

import 'card.dart';
import 'utils.dart';

class gridCards extends StatelessWidget {
  const gridCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.2,
          ),
          itemBuilder: (ctx, index) => card(data: data[index]),
        ),
      ),
    );
  }
}
