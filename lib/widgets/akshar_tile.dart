import 'package:Scrum/index.dart';

class AksharTile extends StatefulWidget {
  Individual individual;

  AksharTile({this.individual});

  @override
  _AksharTileState createState() => _AksharTileState();
}

class _AksharTileState extends State<AksharTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 16, 8, 0),
      decoration: AppTheme.tileDecoration,
      child: ListTile(
        onTap: () async {
          await FlurryAnalytics.logEvent('Clicked on Akshar Tile!');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                individual: widget.individual,
              ),
            ),
          );
          setState(() {
            widget.individual.tpw = widget.individual.tpw;
          });
        },
        title:
            Text('${widget.individual.name}', style: AppTheme.tileTitleStyle),
        subtitle: Text('Time / Week : ${widget.individual.tpw} hrs',
            style: AppTheme.tileSubtitleStyle),
        trailing: Text(
            ' Level\n${widget.individual.overall.toStringAsFixed(2)} / 10',
            style: AppTheme.tileTitleStyle),
      ),
    );
  }
}
