import 'index.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await setupModelLocator();
  locator<TaskModel>()
      .setTask(await locator<SqliteDatabaseService>().getTask());
  locator<IndividualModel>()
      .setIndividual(await locator<SqliteDatabaseService>().getIndividual());
  locator<AssignmentModel>()
      .setAssignment(await locator<SqliteDatabaseService>().getAssignedTask());
  await getData();
  await FlurryAnalytics.initialize(
      androidKey: "245H95VR5NQNF2WN4FJ9",
      iosKey: "QM8ZKFBYJC5YF6HQPQK",
      enableLog: true);
  await FlurryAnalytics.logEvent('App_Started');
  runApp(MyApp());
}

Map<String, double> tkkMap = new Map<String, double>();
Map<String, double> hrsMap = new Map<String, double>();
double totalTPW = 0, avgLevel = 0;

Future<void> getData() async {
  List<Task> task = await locator<SqliteDatabaseService>().getTask();
  List<Assignment> assign =
      await locator<SqliteDatabaseService>().getAssignedTask();
  List<Individual> indi =
      await locator<SqliteDatabaseService>().getIndividual();
  List<int> aasii = [];
  double active = 0,
      pending = 0,
      pendingHrs = 0,
      completed = 0,
      completedHrs = 0;
  for (Assignment a in assign) {
    if (a.progress < 5) {
      active += 1;
    } else {
      completed += 1;
      aasii.add(a.id);
    }
  }
  for (Task t in task) {
    if (aasii.contains(t.id)) {
      completedHrs += t.eta;
    } else {
      pendingHrs += t.eta;
    }
    if (!t.assigned) pending += 1;
  }

  for (Individual i in indi) {
    totalTPW += i.tpw;
    avgLevel += i.overall;
  }
  avgLevel /= indi.length;
  tkkMap = {"Pending": pending, "Completed": completed, "Active": active};
  hrsMap = {'Pending': pendingHrs, 'Completed': completedHrs};
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konnex Support',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Dashboard(tasks: tkkMap, hrs: hrsMap, tpw: totalTPW, avgL: avgLevel),
    TaskScreen(),
    AssignmentScreen(),
    AksharScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Assignment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Akshar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(0, 49, 88, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
