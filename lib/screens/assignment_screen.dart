import 'package:Konnex/index.dart';

class AssignmentScreen extends StatefulWidget {
  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  List<AssignmentTile> getTiles(List<Assignment> assignment) {
    List<AssignmentTile> assignmentTile = new List<AssignmentTile>();
    assignment?.forEach((assign) {
      assignmentTile.add(AssignmentTile(assign: assign));
    });
    return assignmentTile;
  }

  @override
  void initState() {
    super.initState();
    FlurryAnalytics.logEvent("Navigated to Assignment");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        shadowColor: AppTheme.appBarShadowColor,
        centerTitle: true,
        title: Text('Assignment', style: AppTheme.appBarStyle),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 14),
        //     child: GestureDetector(
        //         child: Icon(
        //       Icons.search,
        //       color: AppTheme.secondaryColor,
        //     )),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider.value(
          value: locator<AssignmentModel>(),
          child: Consumer<AssignmentModel>(
            builder: (ctx, model, _) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: getTiles(model.assignment),
            ),
          ),
        ),
      ),
    );
  }
}

// <Widget>[
//   AssignmentTile(
//       assign:
//           Assignment(name: 'Saurabh Pethani', id: 1, progress: 2)),
// ],
