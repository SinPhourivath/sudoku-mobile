import 'dart:math';

import 'sudoku_util.dart';

class SudokuGenerator {
  late List<List<int>> board;

  SudokuGenerator() {
    board = List.generate(9, (_) => List.filled(9, 0));
  }

  // Create a whole board and remove number to create the Sudoku
  // to make sure the board is solvable
  void generateValidBoard() {
    _fillBoard(row: 0, col: 0);
  }

  bool _fillBoard({required int row, required int col}) {
    if (row == 9) return true;
    if (col == 9) return _fillBoard(row: row + 1, col: 0);

    List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    // Apparently, shuffle alone can't garenteen randomness?
    // It is based on speed, time... etc, which chould leads to repetitve
    numbers.shuffle(Random());

    for (int number in numbers) {
      if (SudokuUtils.isSafe(board, row, col, number)) {
        board[row][col] = number;
        if (_fillBoard(row: row, col: col + 1)) return true;
        board[row][col] = 0; // Backtrack
      }
    }

    return false;
  }

  // Remove numbers to create a Sudoku board
  void removeNumbers(int cellsToRemove) {
    Random rand = Random();

    // Randomly remove cells
    while (cellsToRemove > 0) {
      int row = rand.nextInt(9);
      int col = rand.nextInt(9);

      if (board[row][col] != 0) {
        board[row][col] = 0;
        cellsToRemove--;
      }
    }
  }

  List<List<int>> getCopyOfBoard() {
    return board.map<List<int>>((row) => List<int>.from(row)).toList();
  }
}
