import 'package:flutter/material.dart';


Color primary = const Color(0xFFFF8989);
Color accentColor = const Color(0xFFFF6666);
Color background = const Color(0xFFFFEADD);
Color buttonColors = const Color(0xFFFCAEAE);

String primaryFont = 'Kaushan';
String secondaryFont = 'Diphy';
String textoFont = 'Ysabeau';

ThemeData styles = ThemeData(
  brightness: Brightness.light,
  primaryColor: primary,
  primaryColorLight: primary,
  appBarTheme: AppBarTheme(
    color: primary,
    shadowColor: Colors.grey,
    elevation: 7,
    titleTextStyle:const  TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Kaushan'
    ),
  ),

  scaffoldBackgroundColor: background,

  // texto
  textTheme: TextTheme(
    titleMedium: TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      fontFamily: primaryFont
    )
  ),

  // Buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      backgroundColor: accentColor,
      foregroundColor: Colors.white,
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
        fontStyle: FontStyle.italic,
        fontFamily: secondaryFont
      )

    )
  )

);


Widget getSpacer(double height) => SizedBox(height: height,); 