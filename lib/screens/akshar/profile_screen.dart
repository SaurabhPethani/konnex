import 'package:Scrum/index.dart';

class ProfileScreen extends StatefulWidget {
  Individual individual;
  String name;
  double knowledge = 0,
      understanding = 0,
      specialize = 0,
      efficiency = 0,
      overall = 0;
  int tpw = 0;
  ProfileScreen({this.individual}) {
    knowledge = individual.knowledge;
    understanding = individual.understanding;
    efficiency = individual.efficiency;
    specialize = individual.specialize;
    overall = (knowledge + understanding + efficiency + specialize) / 4;
    tpw = individual.tpw;
    name = individual.name;
  }
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double size = 23;
  int itemCount = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        shadowColor: AppTheme.appBarShadowColor,
        centerTitle: true,
        title: Text('Profile', style: AppTheme.appBarStyle),
        actions: [
          GestureDetector(
              onTap: () {
                locator<SqliteDatabaseService>().undoTask(widget.individual.name);
                locator<IndividualModel>().deleteIndividual(widget.individual);
                locator<SqliteDatabaseService>()
                    .deleteIndividual(widget.individual.name);
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                child: Icon(Icons.delete, color: AppTheme.primaryColor),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              // Text('Name', style: AppTheme.secondaryTextStyle),
              // SizedBox(height: 10),
              // Text(widget.individual.name, style: AppTheme.primaryTextStyle),
              // SizedBox(height: 10),
              TextFormField(
                initialValue: widget.individual.name,
                cursorColor: Theme.of(context).hintColor,
                cursorWidth: 0.7,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  isDense: true,
                  labelStyle: AppTheme.secondaryTextStyle,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                onChanged: (String val) {
                  widget.name = val;
                },
              ),
              TextFormField(
                initialValue: widget.individual.tpw.toString(),
                cursorColor: Theme.of(context).hintColor,
                cursorWidth: 0.7,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Times/Week',
                  isDense: true,
                  labelStyle: AppTheme.secondaryTextStyle,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                onChanged: (String val) {
                  widget.tpw = int.parse(val);
                },
              ),
              SizedBox(height: 10),
              Text('Overall', style: AppTheme.secondaryTextStyle),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: (widget.knowledge +
                        widget.understanding +
                        widget.specialize) /
                    3,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                unratedColor: Colors.amber.withAlpha(50),
                itemCount: itemCount,
                itemSize: size,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rt) {},
                updateOnDrag: true,
              ),
              SizedBox(height: 10),
              Text('Knowledge', style: AppTheme.secondaryTextStyle),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: widget.individual.knowledge,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                unratedColor: Colors.amber.withAlpha(50),
                itemCount: itemCount,
                itemSize: size,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print('Knowledge Rating ' + rating.toString());
                  setState(() {
                    widget.knowledge = rating;
                  });
                },
                updateOnDrag: true,
              ),
              SizedBox(height: 10),
              Text('Understanding', style: AppTheme.secondaryTextStyle),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: widget.individual.understanding,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                unratedColor: Colors.amber.withAlpha(50),
                itemCount: itemCount,
                itemSize: size,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print('Understanding Rating ' + rating.toString());
                  setState(() {
                    widget.understanding = rating;
                  });
                },
                updateOnDrag: true,
              ),
              SizedBox(height: 10),
              Text('Specialization', style: AppTheme.secondaryTextStyle),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: widget.individual.specialize,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                unratedColor: Colors.amber.withAlpha(50),
                itemCount: itemCount,
                itemSize: size,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print('Specialization Rating ' + rating.toString());
                  setState(() {
                    widget.specialize = rating;
                  });
                },
                updateOnDrag: true,
              ),
              SizedBox(height: 10),
              Text('Efficiency', style: AppTheme.secondaryTextStyle),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: widget.individual.efficiency,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                unratedColor: Colors.amber.withAlpha(50),
                itemCount: itemCount,
                itemSize: size,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print('Efficiency Rating ' + rating.toString());
                  setState(() {
                    widget.efficiency = rating;
                  });
                },
                updateOnDrag: true,
              ),
              SizedBox(height: 10),
              Text('Total Task Completed', style: AppTheme.secondaryTextStyle),
              SizedBox(height: 10),
              Text(widget.individual.taskCompleted.toString(),
                  style: AppTheme.primaryTextStyle),
              SizedBox(height: 10),
              Text('Total Task Undertaken', style: AppTheme.secondaryTextStyle),
              SizedBox(height: 10),
              Text(widget.individual.taskUndertaken.toString(),
                  style: AppTheme.primaryTextStyle),
              SizedBox(height: 10),
              Text('No. Of Hrs Practiced', style: AppTheme.secondaryTextStyle),
              SizedBox(height: 10),
              Text(widget.individual.noOfHrsPrac.toString() + "hrs",
                  style: AppTheme.primaryTextStyle),
              SizedBox(height: 10),
              RaisedButton(
                child: Text('Update',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                color: AppTheme.primaryColor,
                onPressed: () {
                  widget.individual.knowledge = widget.knowledge;
                  widget.individual.understanding = widget.understanding;
                  widget.individual.efficiency = widget.efficiency;
                  widget.individual.specialize = widget.specialize;
                  widget.individual.overall = (widget.knowledge +
                          widget.understanding +
                          widget.specialize) /
                      3;
                  widget.individual.tpw = widget.tpw;
                  widget.individual.name = widget.name;

                  locator<SqliteDatabaseService>()
                      .insertIndividual(widget.individual);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
