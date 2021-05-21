import 'package:Konnex/index.dart';
import 'package:flutter/cupertino.dart';

class CupertinoAppBar extends AppBar {
  String appTitle;

  CupertinoAppBar(@required this.appTitle);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.appBarColor,
      shadowColor: AppTheme.appBarShadowColor,
      centerTitle: true,
      title: Text('Team', style: AppTheme.appBarStyle),
      actions: [
        GestureDetector(
            child: Icon(
          Icons.search,
          color: AppTheme.secondaryColor,
        ))
      ],
    );
  }
}
