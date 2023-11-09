import 'package:expence_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorSchem =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 97, 170, 163));

//dark theam insert
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      //dark theme
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      //light theme
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorSchem,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorSchem.onPrimaryContainer,
            foregroundColor: kColorSchem.primaryContainer),
        cardTheme: const CardTheme().copyWith(
          color: kColorSchem.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorSchem.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorSchem.onSecondaryContainer,
                  fontSize: 14),
            ),
      ),
      //dark mode
      themeMode: ThemeMode.system, //default system
      home: const Expenses(),
    ),
  );
}
