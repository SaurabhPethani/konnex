import 'package:Scrum/index.dart';

class TaskAssignTile extends StatefulWidget {
  Individual individual;
  Task task;
  Assignment assign;
  TaskAssignTile({this.task, this.individual, this.assign});

  @override
  _TaskAssignTileState createState() => _TaskAssignTileState();
}

class _TaskAssignTileState extends State<TaskAssignTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      decoration: AppTheme.tileDecoration,
      child: ListTile(
          title:
              Text('${widget.individual.name}', style: AppTheme.tileTitleStyle),
          subtitle: Text('Match: ${widget.individual.perfectMatch}%',
              style: AppTheme.tileSubtitleStyle),
          trailing: GestureDetector(
              onTap: () async {
                await FlurryAnalytics.logEvent('Clicked on Assign Button!');
                if (!widget.task.assigned) {
                  print("creating Assignment Object");
                  Assignment assign = Assignment(
                      id: widget.task.id,
                      name: widget.individual.name,
                      timeTaken: 0,
                      progress: 0,
                      startDate: DateTime.now().toString());
                  locator<AssignmentModel>().addAssignment(assign);

                  widget.task.assigned = true;
                  // locator<TaskModel>().deleteTask(widget.task);
                  locator<SqliteDatabaseService>()
                      .updateTask(widget.task.id.toString(), true);
                  tkkMap['Pending'] -= 1;
                  tkkMap['Active'] += 1;
                  locator<SqliteDatabaseService>().insertAssignment(assign);
                } else {
                  widget.assign = locator<AssignmentModel>()
                      .getAssignmentById(widget.task.id);
                  widget.assign?.name = widget.individual.name;

                  locator<SqliteDatabaseService>()
                      .updateAssignment(widget.task.id, widget.individual.name);
                  locator<AssignmentModel>()
                      .updateAssignment(widget.task.id, widget.individual.name);
                  print(widget.assign?.name);
                }
                widget.individual.taskUndertaken += 1;
                locator<SqliteDatabaseService>().updateIndividual(
                    widget.individual.name,
                    widget.individual.taskUndertaken.toString());
                Navigator.of(context).pop();
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(color: Colors.white, spreadRadius: 1.5)
                      ]),
                  child: Text('Assign', style: AppTheme.primaryTextStyle)))),
    );
  }
}
