import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeCustom {
  static const Color primaryColor = Color(0xffb100e8);

  static ThemeData get lightTheme => ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xffe5e4e2),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      useMaterial3: true);

  static ThemeData get darkTheme => ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xff242124),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      useMaterial3: false);
}
