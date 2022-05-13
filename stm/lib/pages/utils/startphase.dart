import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/tasktimerpage.dart';

class StartPhase extends StatelessWidget {
  const StartPhase({
    Key? key,
    required this.animation,
    required this.task,
  }) : super(key: key);

  final Animation<double> animation;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      height: Get.size.width,
      padding: EdgeInsets.all(40),
      child: Stack(
        alignment: Alignment.center,
        children: [
          RotationTransition(
            turns: this.animation,
            child: SvgPicture.asset(
              'assets/images/start_btn_bg.svg',
              width: Get.size.width,
              color: Colors.green,
            ),
          ),
          GestureDetector(
            onTap: () => Get.to(
              () => TaskTimerPage(task: task),
              duration: Duration(milliseconds: 500),
              transition: Transition.rightToLeft,
              curve: Curves.easeIn,
            ),
            child: SvgPicture.asset(
              'assets/images/start_btn.svg',
            ),
          ),
        ],
      ),
    );
  }
}
