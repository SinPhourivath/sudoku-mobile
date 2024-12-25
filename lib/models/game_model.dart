import '../models/difficulity_model.dart';
import '../utils/generator_util.dart';

class Game {
  List<List<int>> gameBoard;
  List<List<int>> solutionBoard;
  Difficulty difficulity;
  DateTime startTime;

  // Create a new game
  Game.newGame(this.difficulity)
      : gameBoard = [],
        solutionBoard = [],
        startTime = DateTime.now() {
    SudokuGenerator generator = SudokuGenerator();
    generator.generateValidBoard();

    // Save the solution board
    solutionBoard = List.from(generator.getCopyOfBoard());

    // Remove numbers based on difficulty
    generator.removeNumbers(difficulity.numbersToRemove);
    gameBoard = generator.getCopyOfBoard();
  }
}
