import 'package:stm/models/phase.dart';
import 'package:stm/utils/Categories.dart';

class Task {
  String name;
  Categories category;
  List<Phase> phases = [];

  Task({required this.name, required this.category});

  String get getCategory => category.toString().split(".").last;

  void addPhase(Phase newPhase) => this.phases.add(newPhase);
}
