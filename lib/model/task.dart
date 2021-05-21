import 'package:Scrum/index.dart';
import 'individual.dart';

Map<String, int> mapTaskType = {
  'Component': 1,
  'Animation': 2,
  'Prototype': 3,
  'Screen': 4,
  'Integration': 5
};

class Task {
  int id, priority, level, eta;
  String desc, type;
  bool assigned;

  List<Individual> bestMatch = new List<Individual>();

  Task(
      {this.id,
      this.priority,
      this.level,
      this.eta,
      this.desc,
      this.type,
      this.assigned});

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'desc': desc,
      'type': type,
      'priority': priority.toString(),
      'level': level.toString(),
      'eta': eta.toString(),
      'assigned': assigned ? 'yes' : 'no'
    };
  }

  factory Task.fromMap(Map<String, dynamic> tk) => Task(
      id: int.parse(tk['id']),
      desc: tk['desc'],
      type: tk['type'],
      priority: int.parse(tk['priority']),
      level: int.parse(tk['level']),
      eta: int.parse(tk['eta']),
      assigned: tk['assigned'] == 'yes' ? true : false);

  List<Individual> calculateBestMatch() {
    locator<IndividualModel>().individual.forEach((individual) {
      int perfectPercent = 0;
      if (mapTaskType[type] <= individual.specialize)
        perfectPercent += 33;
      else
        perfectPercent += 16;
      if (level <= individual.overall)
        perfectPercent += 33;
      else
        perfectPercent += 16;
      if (individual.tpw - eta >= 0)
        perfectPercent += 34;
      else if (1.5 * individual.tpw >= 0)
        perfectPercent += 16;
      else
        perfectPercent += 8;

      individual.perfectMatch = perfectPercent;
      bestMatch.add(individual);
    });

    bestMatch.sort((a, b) => a.perfectMatch.compareTo(b.perfectMatch));
    return bestMatch;
  }
}
