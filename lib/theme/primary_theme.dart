import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_app/theme/styled_colors.dart';

abstract class PrimaryTheme {
  PrimaryTheme._();

  static ThemeData generateTheme(BuildContext context) {
    return ThemeData(
      snackBarTheme: SnackBarThemeData(actionTextColor: Colors.white),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(color: StyledColors.PRIMARY_COLOR),
        unselectedLabelStyle: TextStyle(color:Colors.red),
      ),
      brightness: Brightness.light,
      primaryColorBrightness: Brightness.light,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: StyledColors.DARK_BLUE,fontSize: 17),
        hintStyle: TextStyle(color:  StyledColors.DARK_BLUE, fontSize: 17),
        filled: true,
        fillColor: StyledColors.LIGHT_GREEN.withOpacity(0.3),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: StyledColors.DARK_GREEN.withOpacity(0.3), width: 1),
        ),
        alignLabelWithHint: false,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: StyledColors.DARK_GREEN.withOpacity(0.3), width: 1),
        ),

      ),
      textTheme: GoogleFonts.cabinTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }
}
