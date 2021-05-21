import 'package:Konnex/index.dart';

class AssignmentTile extends StatelessWidget {
  Assignment assign;
  Task task;
  Individual indi;
  AssignmentTile({this.assign}) {
    task = locator<TaskModel>().getTaskFromId(assign.id);
    indi = locator<IndividualModel>().getIndividualByName(assign.name);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 16, 8, 0),
      decoration: AppTheme.tileDecoration,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProgressTaskScreen(
                assign: assign,
                task: task,
                individual: indi,
              ),
            ),
          );
        },
        title: Text('${assign.name}', style: AppTheme.tileTitleStyle),
        subtitle: Text('Progress: ${assign.progress} / 5',
            style: AppTheme.tileSubtitleStyle),
        trailing: Text('#${assign.id}', style: AppTheme.tileTitleStyle),
      ),
    );
  }
}
