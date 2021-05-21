import 'dart:convert';
import 'abstract_task.dart';

class Assignment extends AbstractTask {
  int id;
  double progress, timeTaken;
  String name;
  String startDate;
  Assignment(
      {this.id, this.name, this.progress, this.timeTaken, this.startDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'name': name,
      'progress': progress.toString(),
      'timeTaken': timeTaken.toString(),
      'startDate': startDate
    };
  }

  factory Assignment.fromMap(Map<String, dynamic> assign) => Assignment(
      id: int.parse(assign['id']),
      name: assign['name'],
      progress: double.parse(assign['progress']),
      timeTaken: double.parse(assign['timeTaken']),
      startDate: assign['startDate']);
}
