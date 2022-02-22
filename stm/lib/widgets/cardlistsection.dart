import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/controllers/appcontroller.dart';
import 'package:stm/utils/Categories.dart';
import 'package:stm/utils/appcolors.dart';

class CardListSection extends StatelessWidget {
  const CardListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(builder: (ctr) {
      // ctr.getTasks();
      return Expanded(
        child: ListView.builder(
          itemCount: ctr.tasks.length,
          itemBuilder: (content, index) {
            var task = ctr.tasks[index];
            var icon;
            switch (task.category) {
              case Categories.work:
                icon = Icons.work_outline_outlined;
                break;
              case Categories.entertainment:
                icon = Icons.games_outlined;
                break;
              case Categories.sport:
                icon = Icons.sports_football_outlined;
                break;
              case Categories.other:
                icon = Icons.unarchive_outlined;
                break;
            }
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: 80,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                  color: index.isEven ? ORANGE_WEB : RICH_BLACK_FOGRA_29,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: PLATINUM, spreadRadius: 2),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ListTile(
                      leading: Icon(
                        icon,
                        color: index.isOdd ? ORANGE_WEB : RICH_BLACK_FOGRA_29,
                      ),
                      title: Text(
                        task.name,
                        style: GoogleFonts.cabin(
                          textStyle: TextStyle(
                              color: WHITE, fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Text(
                        task.category.name,
                        style: GoogleFonts.martelSans(
                          textStyle: TextStyle(color: PLATINUM),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: 70,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        backgroundColor:
                            index.isOdd ? ORANGE_WEB : RICH_BLACK_FOGRA_29,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: index.isEven ? ORANGE_WEB : RICH_BLACK_FOGRA_29,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
