import 'package:stm/models/phase.dart';
import 'package:stm/utils/Categories.dart';

class Task {
  String name;
  Categories category;
  List<Phase> phases;

  Task({required this.name, required this.category, required this.phases});
}
