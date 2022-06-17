import 'package:get/get.dart';
import 'package:stm/models/phase.dart';

class TimerController extends GetxController {
  var td = '00:00:00';
  late Phase newPhase;

  void timeDiff() {
    newPhase.endTime = DateTime.now();
    Duration duration = newPhase.endTime.difference(newPhase.startTime);
    td =
        "${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
    this.update();
  }
}
