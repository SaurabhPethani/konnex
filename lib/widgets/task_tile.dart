import 'package:Scrum/index.dart';

class TaskTile extends StatefulWidget {
  // String desc, type, assign;
  // int id, priority, level;
  // double eta;

  Task task;
  TaskTile({this.task});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 16, 8, 0),
      decoration: AppTheme.tileDecoration,
      child: ListTile(
        onTap: () async {
          await FlurryAnalytics.logEvent('Clicked on Task Tile!');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TaskDescScreen(task: widget.task),
            ),
          );
        },
        isThreeLine: true,
        title: Text('${widget.task.type}', style: AppTheme.tileTitleStyle),
        subtitle: Text(
            'Level:      ${widget.task.level} / 10 \nPriority:   ${widget.task.priority} / 5',
            style: AppTheme.tileSubtitleStyle),
        trailing:
            Text('ETA:\n${widget.task.eta}hrs', style: AppTheme.tileTitleStyle),
      ),
    );
  }
}
