import 'package:Konnex/index.dart';
import 'assignment.dart';

class AssignmentModel with ChangeNotifier {
  List<Assignment> assignment = new List<Assignment>();

  List<Assignment> get assignments => this.assignment;

  void addAssignment(Assignment assign) {
    assignment.add(assign);
    notifyListeners();
  }

  void deleteAssignment(Assignment assign) {
    assignment.remove(assign);
    notifyListeners();
  }

  void setAssignment(List<Assignment> assign) {
    assignment = assign;
    notifyListeners();
  }

  Assignment getAssignmentById(int id) {
    return assignment.firstWhere((assign) => assign.id == id,
        orElse: () => Assignment());
  }

  void updateAssignment(int id, String name) {
    assignment.where((assign) => assign.id == id).map((ass) => ass.name = name);
    notifyListeners();
  }
}
