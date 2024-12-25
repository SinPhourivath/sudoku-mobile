import '../models/difficulity_model.dart';
import '../utils/generator_util.dart';

class Game {
  List<List<int>> board;
  List<List<int>> solutionBoard;
  Difficulity difficulity;
  DateTime startTime;

  // Create a new game
  Game.newGame(this.difficulity)
      : board = [],
        solutionBoard = [],
        startTime = DateTime.now() {
    SudokuGenerator generator = SudokuGenerator();
    generator.generateValidBoard();

    // Save the solution board
    solutionBoard = List.from(generator.getCopyOfBoard());

    // Remove numbers based on difficulty
    generator.removeNumbers(difficulity.numberToRemove);
    board = generator.getCopyOfBoard();
  }
}
