import 'dart:math';

import 'package:stm/models/phase.dart';
import 'package:stm/utils/Categories.dart';

class Task {
  final int id;
  final String name;
  final Categories category;
  final List<Phase> phases;

  Task(
      {required this.id,
      required this.name,
      required this.category,
      required this.phases}) {}

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "category": this.category.name,
      "phases": this.phases.map((element) => element.toMap()).toList(),
    };
  }

  factory Task.fromMap(int id, Map<String, dynamic> map) {
    List<Phase> tempPhases = [];
    for (int i = 0; i < map['phases'].length; i++) {
      tempPhases.add(Phase.fromMap(map['phases'][i]));
    }
    Categories tempCategory = Categories.values
        .firstWhere((element) => element.name == map['category']);
    return Task(
      id: id,
      name: map['name'],
      category: tempCategory,
      phases: tempPhases,
    );
  }

  Task copyWith(
      {int? id, String? name, Categories? category, List<Phase>? phases}) {
    return Task(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        phases: phases ?? [...this.phases]);
  }
}
