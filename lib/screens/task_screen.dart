import 'package:Scrum/index.dart';

class TaskScreen extends StatefulWidget {
  List<Task> task;

  TaskScreen({this.task});
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<TaskTile> getTiles(List<Task> task) {
    List<TaskTile> taskTile = new List<TaskTile>();
    task?.forEach((tk) {
      if (!tk.assigned) taskTile.add(new TaskTile(task: tk));
    });
    return taskTile;
  }

  @override
  void initState() {
    super.initState();
    FlurryAnalytics.logEvent("Navigated to Task");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: locator<TaskModel>(),
      child: Consumer<TaskModel>(
        builder: (ctx, model, _) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: AppTheme.appBarColor,
              shadowColor: AppTheme.appBarShadowColor,
              centerTitle: true,
              title: Text('Tasks', style: AppTheme.appBarStyle),
              actions: [
                // GestureDetector(
                //   onTap: null,
                //   child: Icon(
                //     Icons.filter,
                //     color: AppTheme.primaryColor,
                //   ),
                // )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: getTiles(model.tasks)),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await FlurryAnalytics.logEvent('Press on Task Add Float!');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TaskAdd()));
              },
              child: Icon(Icons.add, color: AppTheme.appBarColor),
              backgroundColor: AppTheme.primaryColor,
            )),
      ),
    );
  }
}
// <Widget>[
//               TaskTile(
//                   task: new Task(
//                       id: 1,
//                       type: "Component",
//                       level: 4,
//                       priority: 2,
//                       eta: 15)),
//             ]
