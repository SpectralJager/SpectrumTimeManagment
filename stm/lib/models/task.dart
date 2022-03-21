import 'package:flutter/material.dart';

import 'phase.dart';

class Task {
  final int id;
  final String name;
  final List<Phase> phases;
  final Color bgColor;
  final Color txtColor;

  Task(
      {required this.id,
      required this.name,
      required this.phases,
      required this.bgColor,
      required this.txtColor}) {}

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "phases": this.phases.map((element) => element.toMap()).toList(),
      "bgColor": this.bgColor.hashCode,
      "txtColor": this.txtColor.hashCode,
    };
  }

  factory Task.fromMap(int id, Map<String, dynamic> map) {
    List<Phase> tempPhases = [];
    for (int i = 0; i < map['phases'].length; i++) {
      tempPhases.add(Phase.fromMap(map['phases'][i]));
    }
    return Task(
      id: id,
      name: map['name'],
      phases: tempPhases,
      bgColor: Color(map['bgColor']),
      txtColor: Color(map['txtColor']),
    );
  }

  Task copyWith(
      {int? id,
      String? name,
      List<Phase>? phases,
      Color? bgColor,
      Color? txtColor}) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      phases: phases ?? [...this.phases],
      bgColor: bgColor ?? this.bgColor,
      txtColor: txtColor ?? this.txtColor,
    );
  }

  int phasesTime() {
    int temp = 0;
    for (int i = 0; i < this.phases.length; i++) {
      var tempPhase = this.phases[i];
      temp += tempPhase.endTime.difference(tempPhase.startTime).inMinutes;
    }
    return temp;
  }
}
