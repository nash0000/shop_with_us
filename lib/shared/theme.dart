import 'package:flutter/material.dart';
import 'package:shop_with_us/shared/colors/colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: KMainColor,
    fontFamily: "Pacifico",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    primarySwatch: KMaterialColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: KGreyColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: KGreyColor),
    bodyText2: TextStyle(color: KGreyColor),
  ).apply(
    bodyColor: KSecondaryColor,
    displayColor: KSecondaryColor,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: KMainColor,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: KMainColor2),
    textTheme: TextTheme(
      headline6: TextStyle(color: KTextDarkColor, fontSize: 18),
    ),
  );
}
