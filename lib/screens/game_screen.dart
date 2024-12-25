import 'package:flutter/material.dart';

import '../widgets/topbar.dart';
import '../models/difficulity_model.dart';
import '../models/game_model.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.difficulity});
  final Difficulity difficulity;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<int>> grid = List.generate(9, (_) => List.generate(9, (_) => 0));
  late List<List<int>> solutionBoard;
  int wrongAttempts = 0;
  // late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    // _audioPlayer = AudioPlayer();
    Game game = Game.newGame(widget.difficulity);

    _populateGrid(game.board);
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

  void _saveBoard(List<List<int>> board) {
    solutionBoard = board;
  }

  // Future<void> _playWrongPieceSound() async {
  //   try {
  //     await _audioPlayer.setAsset('assets/sounds/wrong_piece.mp3');
  //     await _audioPlayer.play();
  //   } catch (e) {
  //     print('Error playing sound: $e');
  //   }
  // }

  // @override
  // void dispose() {
  //   _audioPlayer.dispose();
  //   super.dispose();
  // }

  void _endGame() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('You have made 3 wrong attempts. Try again!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TopBar(),
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
                        }
                      } else {
                        // _playWrongPieceSound();
                        setState(() {
                          wrongAttempts++;
                        });

                        if (wrongAttempts >= 3) {
                          _endGame();
                        }
                      }
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: isDarkMode ? Colors.white70 : Colors.black,
                              width: row % 3 == 0 ? 4 : 0,
                            ),
                            left: BorderSide(
                              color: isDarkMode ? Colors.white70 : Colors.black,
                              width: col % 3 == 0 ? 4 : 0,
                            ),
                            right: BorderSide(
                              color: isDarkMode ? Colors.white70 : Colors.black,
                              width: (col + 1) % 3 == 0 ? 4 : 0,
                            ),
                            bottom: BorderSide(
                              color: isDarkMode ? Colors.white70 : Colors.black,
                              width: (row + 1) % 3 == 0 ? 4 : 0,
                            ),
                          ),
                          color: grid[row][col] != 0
                              ? (isDarkMode
                                  ? Colors.blueGrey.shade700
                                  : Colors.blue.shade100)
                              : (isDarkMode ? Colors.black45 : Colors.white),
                        ),
                        child: Center(
                          child: Text(
                            grid[row][col] != 0
                                ? grid[row][col].toString()
                                : '',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
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
    );
  }
}

class NumberCard extends StatelessWidget {
  final int number;
  final bool isDragging;

  const NumberCard({super.key, required this.number, this.isDragging = false});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 45,
      height: 60,
      decoration: BoxDecoration(
        color: isDragging ? Colors.blue.shade300 : Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
          child: Text(
        number.toString(),
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.white70,
          fontSize: 18,
        ),
      )),
    );
  }
}
