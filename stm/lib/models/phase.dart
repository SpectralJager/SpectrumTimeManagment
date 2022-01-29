class Phase {
  int index;
  DateTime startTime;
  DateTime? endTime;

  Phase({required this.index, required this.startTime});

  set ChangeEndTime(DateTime time) => this.endTime = time;
  Duration get duration => (endTime!.difference(startTime));
}
