import 'package:intl/intl.dart';

class Phase {
  final int index;
  final DateTime start_time;
  final DateTime end_time;

  Phase(
      {required this.index, required this.start_time, required this.end_time});

  Map<String, dynamic> toMap() {
    return {
      "index": this.index,
      "startTime": this.start_time.toIso8601String(),
      "endTime": this.end_time.toIso8601String()
    };
  }

  factory Phase.fromMap(Map<String, dynamic> map) {
    return Phase(
      index: map['index'],
      start_time: DateTime.parse(map['startTime']),
      end_time: DateTime.parse(map['endTime']),
    );
  }

  Phase copyWith(int? index, DateTime? start_time, DateTime? end_time) {
    return Phase(
      index: index ?? this.index,
      start_time: start_time ?? this.start_time,
      end_time: end_time ?? this.end_time,
    );
  }

  String get time {
    return "${DateFormat('MM.dd, kk:mm').format(this.start_time)} to ${DateFormat('MM.dd, kk:mm').format(this.end_time)}";
  }

  Duration duration({DateTime? start_point, DateTime? end_point}) {
    Duration duration = this.end_time.difference(this.start_time);
    if (start_point != null) {
      duration = this.end_time.difference(start_time);
    } else if (end_point != null) {
      duration = end_point.difference(this.start_time);
    } else if (start_point != null && end_point != null) {
      duration = end_point.difference(start_point);
    } else {
      duration = this.end_time.difference(this.start_time);
    }
    return duration;
  }
}
