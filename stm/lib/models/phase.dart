class Phase {
  int index;
  String description;
  DateTime startTime;
  DateTime endTime;

  Phase(
      {required this.index,
      required this.description,
      required this.startTime,
      required this.endTime});

  Map<String, dynamic> toMap() {
    return {
      "index": this.index,
      "description": this.description,
      "startTime": this.startTime.toIso8601String(),
      "endTime": this.endTime.toIso8601String()
    };
  }

  factory Phase.fromMap(Map<String, dynamic> map) {
    return Phase(
        index: map['index'],
        description: map['description'],
        startTime: DateTime.parse(map['startTime']),
        endTime: DateTime.parse(map['endTime']));
  }

  int get duration {
    return this.endTime.difference(this.startTime).inMinutes;
  }
}
