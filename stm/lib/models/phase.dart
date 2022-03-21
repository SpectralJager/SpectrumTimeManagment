class Phase {
  int index;
  DateTime startTime;
  DateTime endTime;

  Phase({required this.index, required this.startTime, required this.endTime});

  Map<String, dynamic> toMap() {
    return {
      "index": this.index,
      "startTime": this.startTime.toIso8601String(),
      "endTime": this.endTime.toIso8601String()
    };
  }

  factory Phase.fromMap(Map<String, dynamic> map) {
    return Phase(
        index: map['index'],
        startTime: DateTime.parse(map['startTime']),
        endTime: DateTime.parse(map['endTime']));
  }
}
