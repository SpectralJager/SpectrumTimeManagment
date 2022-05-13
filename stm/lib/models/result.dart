import 'package:flutter/material.dart';
import 'package:stm/models/task.dart';

class Result {
  final String title;
  final String subtitle;
  final int time;
  final Color bgColor;
  final Task task;

  Result({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.bgColor,
    required this.task,
  });
}
