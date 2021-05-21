import 'package:Konnex/index.dart';

class AksharScreen extends StatefulWidget {
  List<Individual> individual;

  AksharScreen({this.individual});
  @override
  _AksharScreenState createState() => _AksharScreenState();
}

class _AksharScreenState extends State<AksharScreen> {
  List<AksharTile> getTiles(List<Individual> ind) {
    List<AksharTile> akTile = [];
    ind?.forEach((indi) {
      akTile.add(AksharTile(individual: indi));
    });
    return akTile;
  }

  @override
  void initState() {
    super.initState();
    FlurryAnalytics.logEvent("Navigated to Akshar ");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: locator<IndividualModel>(),
      child: Consumer<IndividualModel>(
        builder: (ctx, model, _) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: AppTheme.appBarColor,
              shadowColor: AppTheme.appBarShadowColor,
              centerTitle: true,
              title: Text('Team', style: AppTheme.appBarStyle),
              // actions: [
              //   Padding(
              //     padding:
              //         const EdgeInsets.symmetric(vertical: 2.0, horizontal: 14),
              //     child: GestureDetector(
              //         child: Icon(
              //       Icons.search,
              //       color: AppTheme.secondaryColor,
              //     )),
              //   )
              // ],
            ),
            body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: getTiles(model.individual)),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await FlurryAnalytics.logEvent('Press on Akshar add Float!');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AksharAdd()));
              },
              child: Icon(Icons.add, color: AppTheme.appBarColor),
              backgroundColor: AppTheme.primaryColor,
            )),
      ),
    );
  }
}

// <Widget>[

//   AksharTile(
//       individual: Individual(
//           name: 'Saurabh Pethani',
//           knowledge: 1,
//           understanding: 1,
//           specialize: 1,
//           efficiency: 1,
//           overall: 1,
//           tpw: 20,
//           taskUndertaken: 0,
//           noOfHrsPrac: 0,
//           taskCompleted: 0,
//           timelyCompletion: 0)),
// ],
