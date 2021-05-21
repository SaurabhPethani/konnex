import 'package:Scrum/index.dart';

class Rating extends StatelessWidget {
  double rating = 1.0;
  String type;
  Rating({this.rating, this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(type,
            style: TextStyle(
                color: Color.fromRGBO(0, 49, 88, 1),
                fontSize: 16,
                fontWeight: FontWeight.w400)),
        SizedBox(height: 5),
        RatingBar.builder(
          initialRating: rating,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 10,
          itemSize: 25.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) async {
            await FlurryAnalytics.logEvent('Task Progress Updated!');
            print('Rating ' + rating.toString());
            // setState(() {
            //   // _rating = rating;
            // });
          },
          updateOnDrag: true,
        ),
      ],
    );
  }
}
