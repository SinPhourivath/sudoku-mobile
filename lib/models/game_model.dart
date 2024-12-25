import '../models/difficulity_model.dart';
import '../utils/board_generator.dart';

class Game {
  List<List<int>> board;
  List<List<int>> solutionBoard;
  Difficulity difficulity;
  DateTime startTime;

  Game({
    required this.board,
    required this.solutionBoard,
    required this.difficulity,
    required this.startTime,
  });
  
  // Create a new game
  factory Game.newGame(Difficulity difficulity) {
    SudokuGenerator generator = SudokuGenerator();
    generator.generateValidBoard();

    // Save the solution board
    List<List<int>> solutionBoard = generator.getBoard()
        .map((row) => List<int>.from(row))
        .toList();

    // Remove numbers based on difficulty
    generator.removeNumbers(difficulity.numberToRemove);

    return Game(
      board: generator.board,
      solutionBoard: solutionBoard,
      difficulity: difficulity,
      startTime: DateTime.now(),
    );
  }
}
