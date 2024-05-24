import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';

class AplicationTheme {
  const AplicationTheme({required this.theme});
  final ThemeData theme;
  factory AplicationTheme.customTheme() {
    return AplicationTheme(
        theme: ThemeData(
            primarySwatch: Colors.blue,
            cardTheme: const CardTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              elevation: 5,
              shadowColor: Color.fromARGB(55, 0, 0, 0),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.inkWellTextColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            )),
            scaffoldBackgroundColor: ColorConstant.backgroundScaffoldColor));
  }
}
