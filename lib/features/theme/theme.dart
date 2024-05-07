import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFEFBC08);
// const kSecondaryColor = Color(0xFFEFBC08);
const kPrimaryLightColor = Color(0xFFF1E6FF);
// const whiteColor = Color(0xFF121212);
// // const whiteColor = Colors.white;
const greyColor = Colors.grey;
// const blackColor = Colors.white;
// // const blackColor = Colors.black;
// const detailPageTextColor = Color(0xFF2C2C2C);

const double defaultPadding = 16.0;

final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      // selectedIconTheme: IconThemeData(color: Color.fromRGBO(248, 147, 29, 1)),
      // unselectedIconTheme:
      //     IconThemeData(color: Color.fromARGB(255, 128, 128, 128)),
      // selectedItemColor: Color.fromRGBO(248, 147, 29, 1),
      // unselectedItemColor: Color.fromARGB(255, 128, 128, 128),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFF121212),
    ),
    cardTheme: const CardTheme(shadowColor: Color(0xFF121212), elevation: 15),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    shadowColor: const Color(0xFF121212),
    cardColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        maximumSize: const Size(double.infinity, 56),
        minimumSize: const Size(double.infinity, 56),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: kPrimaryLightColor,
      suffixIconColor: kPrimaryColor,
      iconColor: kPrimaryColor,
      prefixIconColor: kPrimaryColor,
      contentPadding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide.none,
      ),
    ));

final darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(36, 36, 36, 1),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromRGBO(36, 36, 36, 1),
      // selectedIconTheme: IconThemeData(color: Color.fromRGBO(248, 147, 29, 1)),
      // unselectedIconTheme:
      //     IconThemeData(color: Color.fromARGB(255, 128, 128, 128)),
      // selectedItemColor: Color.fromRGBO(248, 147, 29, 1),
      // unselectedItemColor: Color.fromARGB(255, 128, 128, 128),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    cardTheme: const CardTheme(shadowColor: Colors.white, elevation: 15),
    bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF121212)),
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
    shadowColor: Colors.white,
    cardColor: const Color(0xFF121212),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        // primary: kPrimaryColor,
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.black,
        shape: const StadiumBorder(),
        maximumSize: const Size(double.infinity, 56),
        minimumSize: const Size(double.infinity, 56),
      ),
    ),
    // textTheme: TextTheme(
    //   textStyle
    // ),
    // text
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: kPrimaryLightColor,
      iconColor: kPrimaryColor,
      prefixIconColor: kPrimaryColor,
      contentPadding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide.none,
      ),
    ));
