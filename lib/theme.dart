import 'index.dart';

class AppTheme {
  static const primaryColor = Color.fromRGBO(0, 49, 88, 1);
  static var secondaryColor = Colors.blueGrey;

  static const primaryTextStyle =
      TextStyle(color: primaryColor, fontSize: 17, fontWeight: FontWeight.w600);
  static var secondaryTextStyle = TextStyle(
      color: secondaryColor, fontSize: 14, fontWeight: FontWeight.w400);

  static const appBarColor = Colors.white;
  static const appBarShadowColor = Color.fromRGBO(0, 49, 88, 1);
  static const appBarStyle =
      TextStyle(color: primaryColor, fontSize: 18, fontWeight: FontWeight.w800);

  static const tileTitleStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17);
  static var tileSubtitleStyle = TextStyle(
      color: Colors.grey[300], fontWeight: FontWeight.w600, fontSize: 15);
  static var tileDecoration = BoxDecoration(
    color: primaryColor,
    borderRadius: BorderRadius.circular(8),
  );
}
