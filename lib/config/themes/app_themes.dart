import 'package:flutter/material.dart';
import 'package:next_movie_app/utils/constants/enums/enums.dart';

class AppThemes {
  static const Color lightBackgroundColor = Color(0xFFF1F1F2);
  static const Color darkBackgroundColor = Color(0xFF306076); // 0xEE011A27

  static const Color lightPrimaryColor = Color(0xFFBCBABE);
  static const Color darkPrimaryColor = Color(0xFFF0810F); //Color(0xFF063852)

  static const Color lightSecondaryColor = Color(0xFFA1D6E2); // 0xFFA1D6E2
  static const Color darkSecondaryColor =
      Color(0xFF063852); //0xFF063852 0xFFacd0c0

  static const Color lightAccentColor = Color(0xFF1995AD);
  static const Color darkAccentColor = Color(0xeeE6DF44);

  static const Color lightTitleTextColor = Color(0xFF9F987F);
  static const Color darkTitleTextColor = Color(0xFF9F987F);

  static const Color lightSubTitleTextColor = Color(0xFF9F987F);
  static const Color darkSubTitleTextColor = Color(0xFFF0810F);

  static const Color lightTextColor = Color(0xFF063852);
  static const Color darkTextColor = Color(0xFFBCBABE); // Color(0xFF9F987F)

  static final Map<AppTheme, ThemeData> appThemeData = <AppTheme, ThemeData>{
    AppTheme.darkMode: ThemeData(
      accentColor: darkAccentColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      primarySwatch: Colors.grey,
      backgroundColor: darkBackgroundColor,
      bottomAppBarColor: darkAccentColor,
      buttonColor: darkPrimaryColor,
      secondaryHeaderColor: darkSecondaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: const TextTheme().copyWith(
        bodyText1: const TextStyle().copyWith(
          color: darkTextColor,
          fontSize: 34.0,
        ),
        // content text, not inside the Cards and not textFields hintText
        bodyText2: const TextStyle().copyWith(
          color: darkTextColor,
        ),
        headline6: const TextStyle().copyWith(
          color: darkTextColor,
          fontSize: 15.0,
        ),
        subtitle1: const TextStyle().copyWith(
          color: darkSubTitleTextColor,
          fontSize: 14.0,
        ),
        subtitle2: const TextStyle().copyWith(
          color: lightTextColor,
          fontSize: 14.0,
        ),
      ),
    ),
    AppTheme.lightMode: ThemeData(
      accentColor: lightAccentColor,
      scaffoldBackgroundColor: lightBackgroundColor,
      primarySwatch: Colors.grey,
      backgroundColor: lightBackgroundColor,
      bottomAppBarColor: lightAccentColor,
      buttonColor: lightPrimaryColor,
      secondaryHeaderColor: lightSecondaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: const TextTheme().copyWith(
        bodyText1: const TextStyle().copyWith(
          color: lightTextColor,
          fontSize: 34.0,
        ),
        // content text, not inside the Cards and not textFields hintText
        bodyText2: const TextStyle().copyWith(
          color: lightTextColor,
        ),
        headline6: const TextStyle().copyWith(
          color: lightTextColor,
          fontSize: 20.0,
        ),
        subtitle1: const TextStyle().copyWith(
          color: Colors.brown,
          fontSize: 14.0,
        ),
        subtitle2: const TextStyle().copyWith(
          color: lightSubTitleTextColor,
          fontSize: 14.0,
        ),
      ),
    ),
  };
}
