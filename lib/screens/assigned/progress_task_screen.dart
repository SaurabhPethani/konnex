import 'package:Konnex/index.dart';
import 'package:intl/intl.dart';

class ProgressTaskScreen extends StatefulWidget {
  Task task;
  Assignment assign;
  Individual individual;
  // Assignment(id: 1, name: "Saurabh Pethani", progress: 2, timeTaken: 10);
  ProgressTaskScreen({this.task, this.assign, this.individual});

  @override
  _ProgressTaskScreenState createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.appBarColor,
          shadowColor: AppTheme.appBarShadowColor,
          centerTitle: true,
          title: Text(widget.task?.type, style: AppTheme.appBarStyle),
          actions: [
            GestureDetector(
                onTap: () {
                  widget.individual.taskUndertaken -= 1;
                  locator<SqliteDatabaseService>().updateIndividual(
                      widget.individual.name,
                      widget.individual.taskUndertaken.toString());
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TaskDescScreen(
                        task: widget.task,
                        assign: widget.assign,
                      ),
                    ),
                  );
                },
                child: Center(
                    child: Text('Re-Assign  ', style: AppTheme.appBarStyle)))
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Task ID', style: AppTheme.secondaryTextStyle),
                SizedBox(height: 10),
                Text("#" + widget.task.id.toString(),
                    style: AppTheme.primaryTextStyle),
                SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description', style: AppTheme.secondaryTextStyle),
                    SizedBox(height: 10),
                    Text('''${widget.task.desc}''',
                        style: AppTheme.primaryTextStyle),
                    SizedBox(height: 12),
                    Text('Priority (1 is highest)',
                        style: AppTheme.secondaryTextStyle),
                    SizedBox(height: 10),
                    Text(widget.task.priority.toString(),
                        style: AppTheme.primaryTextStyle),
                    SizedBox(height: 12),
                    Text('Level (1 is lowest)',
                        style: AppTheme.secondaryTextStyle),
                    SizedBox(height: 10),
                    Text(widget.task.level.toString(),
                        style: AppTheme.primaryTextStyle),
                    Text('Progress', style: AppTheme.secondaryTextStyle),
                    SizedBox(height: 10),
                    RatingBar.builder(
                      initialRating: widget.assign.progress,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      unratedColor: Colors.amber.withAlpha(50),
                      itemCount: 5,
                      itemSize: 30.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print('Rating ' + rating.toString());
                        DateTime start =
                            DateTime.parse(widget.assign.startDate);
                        Duration duration = DateTime.now().difference(start);
                        print(duration.inDays);
                        locator<IndividualModel>().growAsPerRating(rating,
                            widget.individual, widget.task, duration.inDays);

                        if (rating == 5.0) {
                          widget.individual.taskCompleted += 1;
                          locator<SqliteDatabaseService>().updateIndividualTask(
                              widget.individual.name,
                              widget.individual.taskCompleted.toString());
                          hrsMap['Pending'] -= widget.task.eta;
                          hrsMap['Completed'] += widget.task.eta;
                          tkkMap['Active'] -= 1;
                          tkkMap['Completed'] += 1;
                        }
                        print(tkkMap);
                        print(hrsMap);
                        setState(() {
                          widget.assign.progress = rating;
                          widget.assign.timeTaken =
                              duration.inDays * (widget.individual.tpw / 7);
                          locator<SqliteDatabaseService>()
                              .insertAssignment(widget.assign);
                        });
                      },
                      updateOnDrag: true,
                    ),
                    SizedBox(height: 12),
                    Text('ETA', style: AppTheme.secondaryTextStyle),
                    SizedBox(height: 10),
                    Text(widget.task.eta.toString() + "hrs",
                        style: AppTheme.primaryTextStyle),
                    SizedBox(height: 10),
                    Text('Actual Time Left',
                        style: AppTheme.secondaryTextStyle),
                    SizedBox(height: 10),
                    Text(
                        (widget.task.eta - widget.assign.timeTaken).toString() +
                            "hrs",
                        style: AppTheme.primaryTextStyle),
                    SizedBox(height: 10),
                    Text('Actual Time Taken',
                        style: AppTheme.secondaryTextStyle),
                    SizedBox(height: 10),
                    Text(widget.assign.timeTaken.toString() + "hrs",
                        style: AppTheme
                            .primaryTextStyle), // Time Taken cal.(today-startDate )*Time/Day
                    SizedBox(height: 10),
                    Text('Time Required as per progress speed',
                        style: AppTheme.secondaryTextStyle),
                    SizedBox(height: 10),
                    Text(
                        (widget.task.eta -
                                    (widget.task.eta /
                                        5 *
                                        widget.assign.progress))
                                .toString() +
                            "hrs",
                        style: AppTheme.primaryTextStyle),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
