import 'package:flutter/material.dart';
import 'package:sudoku/widgets/app_button.dart';
import 'package:sudoku/widgets/app_topbar.dart';

import '../models/difficulity_model.dart';
import '../screens/game_screen.dart';

class DifficulityScreen extends StatelessWidget {
  const DifficulityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDarkMode
                  ? [Colors.grey[900]!, Colors.black]
                  : [Colors.blue[50]!, Colors.white],
            ),
          ),
          child: Center(
            child: Column(
              children: [
                TopBar(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GameButton(
                          text: "Easy",
                          backgroundColor: Colors.green,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      GameScreen(difficulity: Difficulty.easy),
                                ));
                          }),
                      SizedBox(height: 20),
                      GameButton(
                          text: "Medium",
                          backgroundColor: Colors.orange,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      GameScreen(difficulity: Difficulty.medium),
                                ));
                          }),
                      SizedBox(height: 20),
                      GameButton(
                          text: "Hard",
                          backgroundColor: Colors.red,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      GameScreen(difficulity: Difficulty.hard),
                                ));
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
