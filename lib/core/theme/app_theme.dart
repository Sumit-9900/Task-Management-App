import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final appTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(backgroundColor: Colors.blue, centerTitle: true),
    chipTheme: ChipThemeData(
      labelStyle: TextStyle(color: Colors.black87, fontSize: 16),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    // dropdownMenuTheme: DropdownMenuThemeData(
    //   inputDecorationTheme: InputDecorationTheme(
    //     filled: true,
    //     fillColor: Colors.black,
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(12),
    //       borderSide: BorderSide(color: Colors.grey.shade300),
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(12),
    //       borderSide: BorderSide(color: Colors.blueAccent, width: 2),
    //     ),
    //   ),
    //   textStyle: const TextStyle(
    //     fontSize: 16,
    //     fontWeight: FontWeight.w500,
    //     color: Colors.black87,
    //   ),
    //   menuStyle: MenuStyle(
    //     backgroundColor: WidgetStatePropertyAll(Colors.white),
    //     elevation: WidgetStatePropertyAll(6),
    //     shadowColor: WidgetStatePropertyAll(Colors.black12),
    //     shape: WidgetStatePropertyAll(
    //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    //     ),
    //   ),
    // ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.lightBlue,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      titleTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      subtitleTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black54,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      headerBackgroundColor: Colors.blueAccent,
      headerForegroundColor: Colors.white,
      shadowColor: Colors.grey.shade200,
      elevation: 5,
      yearStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
      dayStyle: TextStyle(fontSize: 16, color: Colors.black87),
      weekdayStyle: TextStyle(fontSize: 14, color: Colors.grey.shade700),
      todayForegroundColor: WidgetStateProperty.all(Colors.blueAccent),
      todayBackgroundColor: WidgetStateProperty.all(Colors.blue.shade100),
      dayForegroundColor: WidgetStateProperty.all(Colors.black87),
      dayOverlayColor: WidgetStateProperty.all(Colors.blue),
      yearOverlayColor: WidgetStateProperty.all(Colors.blue),
      confirmButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.grey.shade200),
        foregroundColor: WidgetStateProperty.all(Colors.black87),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      labelStyle: TextStyle(color: Colors.black87, fontSize: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.blue),
        foregroundColor: WidgetStatePropertyAll(Colors.grey[100]),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.black87,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.blueAccent,
      circularTrackColor: Colors.grey.shade300,
      strokeWidth: 2.0,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
