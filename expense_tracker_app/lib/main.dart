import 'package:expense_tracker_app/my_state/expenses.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

var pColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 161, 106, 2),
);
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 2, 17, 56),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 8, 76, 107),
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight])
  //     .then((fn) {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kDarkColorScheme.onPrimaryContainer,
        foregroundColor: kDarkColorScheme.primaryContainer,
      ),
      cardTheme: const CardTheme().copyWith(
        color: kDarkColorScheme.onPrimaryContainer,
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorScheme.primaryContainer,
        ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
    ),
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: pColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
      ),
      cardTheme: const CardTheme().copyWith(
        color: kColorScheme.inversePrimary,
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer,
        ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
    ),
    home: const Expenses(),
  ));
}
  // );
// }
