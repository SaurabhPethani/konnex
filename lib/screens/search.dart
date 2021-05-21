import 'package:Konnex/index.dart';
import 'package:Konnex/model/abstract_task.dart';
import 'package:flutter/cupertino.dart';

class GlobalSearch extends StatefulWidget {
  @override
  Global_SearchState createState() => Global_SearchState();
}

class Global_SearchState extends State<GlobalSearch> {
  List<IconData> task = [Icons.pending, Icons.done, Icons.work_outline_rounded];
  List tasks = [];
  List assignment=[];
  int segmentedControlValue = 0;

  Widget segmentedControl(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: CupertinoSlidingSegmentedControl(
              groupValue: segmentedControlValue,
              thumbColor: Colors.white,
              backgroundColor: Colors.grey[300],
              children: const <int, Widget>{
                0: Text('Pending'),
                1: Text('Completed'),
                2: Text('In-Progress')
              },
              onValueChanged: (value) {
                setState(() {
                  if (value == 0) {
                    tasks = locator<TaskModel>()
                        .tasks
                        .where((tak) => !tak.assigned)
                        .toList();
                  } else if (value == 1) {
                    assignment = locator<AssignmentModel>()
                        .assignments
                        .where((tak) => tak.progress == 5.0)
                        .toList();
                  } else if (value == 2) {
                    tasks = locator<TaskModel>()
                        .tasks
                        .where((tak) => tak.assigned)
                        .toList();
                  }
                  segmentedControlValue = value;
                });
              }),
        ),
        segmentedControlValue == 1 ? 
        ...assignment
            .map((e) =>
                AssignmentTile(assign: e) )
            .toList() : 
        ...tasks
            .map((e) => TaskTile(task: e))
            .toList()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppTheme.appBarColor,
          shadowColor: AppTheme.appBarShadowColor,
          centerTitle: true,
          title: Text('Tasks', style: AppTheme.appBarStyle),
        ),
        body: segmentedControl(context)
        // SafeArea(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(20.0),
        //       child: GestureDetector(
        //         onTap: () {
        //           setState(() {
        // tasks = locator<TaskModel>()
        //     .tasks
        //     .where((tak) => !tak.assigned)
        //     .toList();
        //           });
        //         },
        //         child: Container(
        //           width: ,
        //           height: 35,
        //           child: Icon(Icons.pending,
        //               color: AppTheme.primaryColor, size: 16),
        //           decoration: BoxDecoration(
        //             color: AppTheme.secondaryColor,
        //             borderRadius: BorderRadius.horizontal(
        //                 left: Radius.circular(30),
        //                 right: Radius.circular(30)),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // Column(children: tasks.map((e) => TaskTile(task: e)).toList())
        //     ],
        //   ),
        // ),

        );
  }
}
