import 'package:get/get.dart';
import 'package:stm/models/phase.dart';

class TimerController extends GetxController {
  var td = '00:00:00'.obs;
  late Phase newPhase;

  void timeDiff() {
    var duration = DateTime.now().difference(this.newPhase.startTime);
    td.value =
        "${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }
}
