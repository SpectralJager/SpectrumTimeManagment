import 'package:flutter/material.dart';

import 'phase.dart';

class Task {
  final int id;
  final String name;
  final String description;
  final List<Phase> phases;
  final Color bgColor;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.phases,
    required this.bgColor,
  }) {}

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "description": this.description,
      "phases": this.phases.map((element) => element.toMap()).toList(),
      "bgColor": this.bgColor.hashCode,
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
      description: map['description'],
      phases: tempPhases,
      bgColor: Color(map['bgColor']),
    );
  }

  Task copyWith({
    int? id,
    String? name,
    String? description,
    List<Phase>? phases,
    Color? bgColor,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      phases: phases ?? [...this.phases],
      bgColor: bgColor ?? this.bgColor,
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

  int get totalDuration {
    var temp = 0;
    for (var item in this.phases) {
      temp += item.duration;
    }
    return temp;
  }
}
