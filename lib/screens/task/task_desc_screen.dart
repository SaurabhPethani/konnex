import 'package:Konnex/index.dart';

class TaskDescScreen extends StatefulWidget {
  Task task;
  Assignment assign;
  String desc;
  int id, priority, level, eta;
  TaskDescScreen({this.task, this.assign}) {
    locator<TaskModel>().calculateBestMatch(task);
    id = task.id;
    priority = task.priority;
    level = task.level;
    eta = task.eta;
    desc = task.desc;
  }

  @override
  _TaskDescScreenState createState() => _TaskDescScreenState();
}

class _TaskDescScreenState extends State<TaskDescScreen>
    with SingleTickerProviderStateMixin {
  List<TaskAssignTile> getAssignTile(List<Individual> indi) {
    List<TaskAssignTile> tat = new List<TaskAssignTile>();
    indi?.forEach((tk) {
      tat.add(new TaskAssignTile(task: widget.task, individual: tk));
    });
    return tat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.appBarColor,
          shadowColor: AppTheme.appBarShadowColor,
          centerTitle: true,
          title: Text(widget.task.type, style: AppTheme.appBarStyle),
          actions: [
            GestureDetector(
                onTap: () {
                  if (widget.task.assigned) {
                    locator<AssignmentModel>().deleteAssignment(widget.assign);
                    locator<SqliteDatabaseService>()
                        .deleteAssignment(widget.task.id.toString());
                  }
                  locator<TaskModel>().deleteTask(widget.task);
                  locator<SqliteDatabaseService>()
                      .deleteTask(widget.task.id.toString());

                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: Icon(Icons.delete, color: AppTheme.primaryColor),
                ))
          ],
        ),
        body: ChangeNotifierProvider.value(
          value: locator<TaskModel>(),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Consumer<TaskModel>(
              builder: (ctx, model, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            initialValue: widget.task.id.toString(),
                            cursorColor: Theme.of(context).hintColor,
                            cursorWidth: 0.7,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'ID',
                              isDense: true,
                              labelStyle: AppTheme.secondaryTextStyle,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                            onChanged: (String val) {
                              widget.id = int.parse(val);
                            },
                          ),
                          TextFormField(
                            initialValue: widget.task.priority.toString(),
                            cursorColor: Theme.of(context).hintColor,
                            cursorWidth: 0.7,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Priority',
                              isDense: true,
                              labelStyle: AppTheme.secondaryTextStyle,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                            onChanged: (String val) {
                              widget.priority = int.parse(val);
                            },
                          ),
                          TextFormField(
                            initialValue: widget.task.level.toString(),
                            cursorColor: Theme.of(context).hintColor,
                            cursorWidth: 0.7,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Level',
                              isDense: true,
                              labelStyle: AppTheme.secondaryTextStyle,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                            onChanged: (String val) {
                              widget.level = int.parse(val);
                            },
                          ),
                          TextFormField(
                            initialValue: widget.task.eta.toString(),
                            cursorColor: Theme.of(context).hintColor,
                            cursorWidth: 0.7,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'ETA',
                              isDense: true,
                              labelStyle: AppTheme.secondaryTextStyle,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                            onChanged: (String val) {
                              widget.eta = int.parse(val);
                            },
                          ),
                          TextFormField(
                            initialValue: widget.task.desc,
                            cursorColor: Theme.of(context).hintColor,
                            cursorWidth: 0.7,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              isDense: true,
                              labelStyle: AppTheme.secondaryTextStyle,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                            onChanged: (String val) {
                              widget.desc = val;
                            },
                          ),
                          SizedBox(height: 10),
                          RaisedButton(
                            child: Text('Update',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                            color: AppTheme.primaryColor,
                            onPressed: () {
                              widget.task.id = widget.id;
                              widget.task.desc = widget.desc;
                              widget.task.priority = widget.priority;
                              widget.task.level = widget.level;
                              widget.task.eta = widget.eta;
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(height: 10),
                          Text('Best Matches',
                              style: AppTheme.secondaryTextStyle),
                          SizedBox(height: 10),
                          // model.bestMatch.isEmpty
                          //     ? CircularProgressIndicator(
                          //         backgroundColor: AppTheme.primaryColor,
                          //       )
                          //     :
                          ...(model.bestMatch)
                              .map((ind) => TaskAssignTile(
                                    task: widget.task,
                                    individual: ind,
                                    assign: widget.assign,
                                  ))
                              .toList()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
