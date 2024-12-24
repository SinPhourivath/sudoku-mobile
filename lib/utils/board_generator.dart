import 'dart:math';

class SudokuGenerator {
  late List<List<int>> board;

  SudokuGenerator() {
    board = List.generate(9, (_) => List.filled(9, 0));
  }

  // Start from [0][0]
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
      if (_isSafe(row, col, number)) {
        board[row][col] = number;
        if (_fillBoard(row: row, col: col + 1)) return true;
        board[row][col] = 0; // Backtrack
      }
    }

    return false; // No valid number found
  }

  // Number can be placed if no repetitive in row, column, and its 3x3 area
  bool _isSafe(int row, int col, int number) {
    return !_inRow(row, number) && !_inCol(col, number) && !_inBox(row, col, number);
  }

  bool _inRow(int row, int number) {
    return board[row].contains(number);
  }

  bool _inCol(int col, int number) {
    for (int i = 0; i < 9; i++) {
      if (board[i][col] == number) return true;
    }
    return false;
  }

  bool _inBox(int row, int col, int number) {
    int boxRow = row - row % 3;
    int boxCol = col - col % 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[boxRow + i][boxCol + j] == number) return true;
      }
    }
    return false;
  }

  // For testing
  void printBoard() {
    for (var row in board) {
      print(row);
    }
  }
}
