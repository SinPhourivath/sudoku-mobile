import 'package:flutter/material.dart';

import '../widgets/app_topbar.dart';
import '../models/difficulity_model.dart';
import '../models/game_model.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.difficulity});
  final Difficulty difficulity;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<int>> grid = List.generate(9, (_) => List.generate(9, (_) => 0));
  late List<List<int>> solutionBoard;

  int wrongAttempts = 0;
  int correctPlacements = 0;

  @override
  void initState() {
    super.initState();
    Game game = Game.newGame(widget.difficulity);

    _populateGrid(game.gameBoard);
    _saveBoard(game.solutionBoard);
  }

  // Transfer game board to the grid
  void _populateGrid(List<List<int>> board) {
    setState(() {
      for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
          grid[i][j] = board[i][j];
        }
      }
    });
  }

  // Save the solution board for correct checking
  void _saveBoard(List<List<int>> board) {
    solutionBoard = board;
  }

  void _showGameDialog({required String title, required String message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                  ..pop()
                  ..pop()
                  ..pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  // Checking one number is better than comparing the whole board everytime
  void _checkGameNearingCompletion() {
    if (correctPlacements >= widget.difficulity.numbersToRemove) {
      _gameWon();
    }
  }

  void _endGame() {
    _showGameDialog(
      title: 'Game Over',
      message: 'You have made 3 wrong attempts. Try again!',
    );
  }

  void _gameWon() {
    _showGameDialog(
      title: 'Congratulations!',
      message: 'You completed the game successfully!',
    );
  }

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
                  ? [Colors.grey.shade900, Colors.black]
                  : [Colors.blue.shade50, Colors.white],
            ),
          ),
          child: Column(
            children: [
              TopBar(),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Wrong Attempts: $wrongAttempts/3',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: wrongAttempts > 1 ? Colors.red : null,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 9,
                          childAspectRatio: 1,
                        ),
                        itemCount: 81,
                        itemBuilder: (context, index) {
                          final row = index ~/ 9;
                          final col = index % 9;
                          return DragTarget<int>(
                            onAcceptWithDetails: (detail) {
                              if (detail.data == solutionBoard[row][col]) {
                                if (grid[row][col] == 0) {
                                  setState(() {
                                    grid[row][col] = detail.data;
                                  });
                                  correctPlacements++;
                                }
                              } else {
                                setState(() {
                                  wrongAttempts++;
                                });
                                if (wrongAttempts >= 3) {
                                  _endGame();
                                }
                              }

                              _checkGameNearingCompletion();
                            },
                            builder: (context, candidateData, rejectedData) {
                              return Container(
                                margin: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.blueGrey,
                                      width: row % 3 == 0 ? 4 : 0,
                                    ),
                                    left: BorderSide(
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.blueGrey,
                                      width: col % 3 == 0 ? 4 : 0,
                                    ),
                                    right: BorderSide(
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.blueGrey,
                                      width: (col + 1) % 3 == 0 ? 4 : 0,
                                    ),
                                    bottom: BorderSide(
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.blueGrey,
                                      width: (row + 1) % 3 == 0 ? 4 : 0,
                                    ),
                                  ),
                                  color: grid[row][col] != 0
                                      ? (isDarkMode
                                          ? Colors.grey.shade800
                                          : Colors.white70)
                                      : (isDarkMode
                                          ? Colors.grey.shade800
                                          : Colors.white70),
                                ),
                                child: Center(
                                  child: Text(
                                    grid[row][col] != 0
                                        ? grid[row][col].toString()
                                        : '',
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 30,
                  runSpacing: 20,
                  children: List.generate(9, (index) {
                    final number = index + 1;
                    return Draggable<int>(
                      data: number,
                      feedback: Material(
                        color: Colors.transparent,
                        child: NumberCard(number: number, isDragging: true),
                      ),
                      childWhenDragging:
                          NumberCard(number: number, isDragging: false),
                      child: NumberCard(number: number),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberCard extends StatelessWidget {
  final int number;
  final bool isDragging;

  const NumberCard({super.key, required this.number, this.isDragging = false});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 45,
      height: 60,
      decoration: BoxDecoration(
        color: isDragging ? Colors.blue.shade300 : Colors.blue.shade700,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
          child: Text(
        number.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      )),
    );
  }
}
