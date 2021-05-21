import 'package:Scrum/index.dart';

class AksharAdd extends StatefulWidget {
  @override
  _AksharAddState createState() => _AksharAddState();
}

class _AksharAddState extends State<AksharAdd> {
  double knowledge = 0,
      understanding = 0,
      specialize = 0,
      efficiency = 0,
      overall = 0;
  int tpw = 0;
  String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        shadowColor: AppTheme.appBarShadowColor,
        centerTitle: true,
        title: Text('Add New Profile', style: AppTheme.appBarStyle),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              TextFormField(
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
                  name = val;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
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
                  tpw = int.parse(val);
                },
              ),
              SizedBox(height: 10),
              Text('Overall', style: AppTheme.secondaryTextStyle),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: (knowledge + understanding + specialize) / 3,
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
                  setState(() {
                    overall = (knowledge + understanding + specialize) / 3;
                  });
                  print("Overall Rating" + overall.toString());
                },
                updateOnDrag: true,
              ),
              SizedBox(height: 10),
              Text('Knowledge', style: AppTheme.secondaryTextStyle),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: knowledge,
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
                  print('Knowledge Rating ' + rating.toString());
                  setState(() {
                    knowledge = rating;
                  });
                },
                updateOnDrag: true,
              ),
              SizedBox(height: 10),
              Text('Understanding', style: AppTheme.secondaryTextStyle),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: understanding,
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
                  print('Understanding Rating ' + rating.toString());
                  setState(() {
                    understanding = rating;
                  });
                },
                updateOnDrag: true,
              ),
              SizedBox(height: 10),
              Text('Specialization', style: AppTheme.secondaryTextStyle),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: specialize,
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
                  print('Specialization Rating ' + rating.toString());
                  setState(() {
                    specialize = rating;
                  });
                },
                updateOnDrag: true,
              ),
              SizedBox(height: 10),
              Text('Efficiency', style: AppTheme.secondaryTextStyle),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: efficiency,
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
                  print('Efficiency Rating ' + rating.toString());
                  setState(() {
                    efficiency = rating;
                  });
                },
                updateOnDrag: true,
              ),
              RaisedButton(
                child: Text('Add',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                color: AppTheme.primaryColor,
                onPressed: () {
                  Individual individual = Individual(
                      name: name,
                      knowledge: knowledge,
                      understanding: understanding,
                      specialize: specialize,
                      efficiency: efficiency,
                      overall: overall,
                      tpw: tpw,
                      taskUndertaken: 0,
                      noOfHrsPrac: 0,
                      taskCompleted: 0,
                      timelyCompletion: 0);
                  locator<IndividualModel>().addIndividual(individual);
                  locator<SqliteDatabaseService>().insertIndividual(individual);
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
