import 'package:flutter/material.dart';
import 'package:sudoku/widgets/topbar.dart';

import '../models/difficulity_model.dart';
import '../screens/game_screen.dart';

class DifficulityScreen extends StatelessWidget {
  const DifficulityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TopBar(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GameScreen(difficulity: Difficulty.easy),
                            ));
                      },
                      child: Text('Easy 6x6'),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GameScreen(difficulity: Difficulty.medium),
                            ));
                      },
                      child: Text('Medium 9x9'),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GameScreen(difficulity: Difficulty.hard),
                            ));
                      },
                      child: Text('Hard 12'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
