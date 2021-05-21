import 'package:Konnex/index.dart';
import 'task.dart';

class TaskModel extends ChangeNotifier {
  List<Task> tasks = new List<Task>();

  void addTask(Task t) {
    tasks.add(t);
    notifyListeners();
  }

  void deleteTask(Task tk) {
    tasks.remove(tk);
    notifyListeners();
  }

  void setTask(List<Task> tk) {
    tasks = tk;
  }

  void updateTask(Task task, bool assign) {
    task.assigned = assign;
    notifyListeners();
  }

  List<Individual> bestMatch = new List<Individual>();
  List<Individual> calculateBestMatch(Task task) {
    bestMatch = [];

    for (var ind in locator<IndividualModel>().individual) {
      int perfectPercent = 0;
      if (mapTaskType[task.type] <= ind.specialize)
        perfectPercent += 33;
      else
        perfectPercent += 16;
      if (task.level <= ind.overall)
        perfectPercent += 33;
      else
        perfectPercent += 16;
      if (ind.tpw - task.eta >= 0)
        perfectPercent += 34;
      else if (1.5 * ind.tpw >= 0)
        perfectPercent += 16;
      else
        perfectPercent += 8;

      ind.perfectMatch = perfectPercent;
      print(perfectPercent);
      bestMatch.add(ind);
    }

    // locator<IndividualModel>().individual.forEach((ind) {
    //   int perfectPercent = 0;
    //   if (mapTaskType[task.type] <= ind.specialize)
    //     perfectPercent += 33;
    //   else
    //     perfectPercent += 16;
    //   if (task.level <= ind.overall)
    //     perfectPercent += 33;
    //   else
    //     perfectPercent += 16;
    //   if (ind.tpw - task.eta >= 0)
    //     perfectPercent += 34;
    //   else if (1.5 * ind.tpw >= 0)
    //     perfectPercent += 16;
    //   else
    //     perfectPercent += 8;

    //   ind.perfectMatch = perfectPercent;
    //   bestMatch.add(ind);
    // });
    print(bestMatch);
    notifyListeners();
  }

  Task getTaskFromId(int id) {
    // for (Task t in tasks) {
    //   if (t.id == id) {
    //     return t;
    //   }
    // }
    return tasks.firstWhere((t) => t.id == id, orElse: () => Task());
  }
}
