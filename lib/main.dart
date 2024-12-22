import 'package:flutter/material.dart';
import 'screens/start_screen.dart';

void main() {
  runApp(const SudokuApp());
}

class SudokuApp extends StatelessWidget {
  const SudokuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sudoku Game',
      theme: ThemeData(
          textTheme: TextTheme(
              titleLarge: TextStyle(
                  fontSize: 60,
                  color: Colors.black,
                  decoration: TextDecoration.none),
              titleMedium: TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  decoration: TextDecoration.none))),
      home: StartScreen(),
    );
  }
}
