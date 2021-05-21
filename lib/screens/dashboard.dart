import 'package:Scrum/index.dart';
import 'package:Scrum/main.dart';

class Dashboard extends StatefulWidget {
  Map<String, double> tasks = new Map<String, double>();
  Map<String, double> hrs = new Map<String, double>();
  double tpw, avgL;
  Dashboard({this.tasks, this.hrs, this.tpw, this.avgL});
  @override
  _DashboardState createState() => _DashboardState();
  // android: 245H95VR5NQNF2WN4FJ9
  // ios: HQM8ZKFBYJC5YF6HQPQK
}

class _DashboardState extends State<Dashboard> {
  List<Color> colorList = [
    Colors.blueGrey,
    Colors.green,
    Colors.red,
    Colors.yellow,
  ];

  ChartType _chartType = ChartType.disc;
  bool _showCenterText = true;
  double _ringStrokeWidth = 40;
  double _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;
  bool _showLegends = true;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;
  LegendPosition _legendPosition = LegendPosition.right;

  @override
  void initState() {
    super.initState();
    FlurryAnalytics.logEvent("Navigated to Dashboard");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        shadowColor: AppTheme.appBarShadowColor,
        centerTitle: true,
        title: Text('Dashboard', style: AppTheme.appBarStyle),
      ),
      body: tkkMap.isEmpty
          ? Center(
              child: Text("Not enough data to show stats",
                  style: AppTheme.appBarStyle))
          : SingleChildScrollView(
              child: Column(children: [
                Container(
                    margin: EdgeInsets.fromLTRB(16, 24, 0, 16),
                    child: Text('Total Tasks: ', style: AppTheme.appBarStyle)),
                PieChart(
                  dataMap: tkkMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: _chartLegendSpacing,
                  chartRadius: 175,
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: _chartType,
                  centerText: _showCenterText ? "Tasks" : null,
                  legendOptions: LegendOptions(
                    showLegendsInRow: _showLegendsInRow,
                    legendPosition: _legendPosition,
                    showLegends: _showLegends,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: _showChartValueBackground,
                    showChartValues: _showChartValues,
                    showChartValuesInPercentage: _showChartValuesInPercentage,
                    showChartValuesOutside: _showChartValuesOutside,
                  ),
                  ringStrokeWidth: _ringStrokeWidth,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(16, 24, 0, 16),
                    child: Text('Total Hrs: ', style: AppTheme.appBarStyle)),
                PieChart(
                  dataMap: hrsMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: _chartLegendSpacing,
                  chartRadius: 175,
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: _chartType,
                  centerText: _showCenterText ? "HRS" : null,
                  legendOptions: LegendOptions(
                    showLegendsInRow: _showLegendsInRow,
                    legendPosition: _legendPosition,
                    showLegends: _showLegends,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: _showChartValueBackground,
                    showChartValues: _showChartValues,
                    showChartValuesInPercentage: _showChartValuesInPercentage,
                    showChartValuesOutside: _showChartValuesOutside,
                  ),
                  ringStrokeWidth: _ringStrokeWidth,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(16, 24, 0, 16),
                    child: Text('Total Time Per Week: ${widget.tpw} ',
                        style: AppTheme.appBarStyle)),
                Container(
                    margin: EdgeInsets.fromLTRB(16, 24, 0, 16),
                    child: Text(
                        'Avg. Level of Akshar: ${widget.avgL.toStringAsFixed(2)} ',
                        style: AppTheme.appBarStyle)),
              ]),
            ),
    );
  }
}
