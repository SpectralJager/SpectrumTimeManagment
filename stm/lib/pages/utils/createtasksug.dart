import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/taskpage.dart';

class CreateTaskSuggestion extends StatelessWidget {
  const CreateTaskSuggestion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: Get.size.width * .65,
          height: Get.size.width * .65,
          child: SvgPicture.asset('assets/images/no_tasks.svg'),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Create a task first",
          textAlign: TextAlign.center,
          style: GoogleFonts.oswald(
            color: Colors.white,
            fontSize: 34,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        FloatingActionButton.extended(
          heroTag: null,
          onPressed: () => Get.to(
            () => TaskPage(
              Task(
                id: 0,
                name: '',
                description: '',
                phases: [],
                bgColor: Colors.red,
              ),
            ),
            duration: Duration(milliseconds: 500),
            transition: Transition.rightToLeft,
            curve: Curves.easeIn,
          ),
          label: Text(
            "Create",
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          ),
          backgroundColor: Colors.green,
        ),
      ],
    );
  }
}
