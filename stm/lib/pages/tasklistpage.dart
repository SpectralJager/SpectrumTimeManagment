import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/pages/utils/card.dart';
import 'package:stm/pages/utils/utils.dart';

import 'utils/searchfield.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Select task or create new...",
          style: GoogleFonts.openSans(fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
        backgroundColor: Colors.red,
      ),
      body: bgWidget(
        bgImage: "assets/images/bg.jpg",
        child: Column(
          children: [
            searchField(),
            Divider(
              height: 4,
              color: Colors.white,
              thickness: 2,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => card(data: data[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
