class SudokuUtils {
  static bool isSafe(List<List<int>> board, int row, int col, int number) {
    return !_inRow(board, row, number) &&
        !_inCol(board, col, number) &&
        !_inBox(board, row, col, number);
  }

  static bool _inRow(List<List<int>> board, int row, int number) {
    return board[row].contains(number);
  }

  static bool _inCol(List<List<int>> board, int col, int number) {
    for (int i = 0; i < 9; i++) {
      if (board[i][col] == number) return true;
    }
    return false;
  }

  static bool _inBox(List<List<int>> board, int row, int col, int number) {
    int boxRow = row - row % 3;
    int boxCol = col - col % 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[boxRow + i][boxCol + j] == number) return true;
      }
    }
    return false;
  }
}
