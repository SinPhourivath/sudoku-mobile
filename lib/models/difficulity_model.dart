// Note for myself, in order for the board to have a unique solution
// it must have at least 17 clues. 81 - 17 = 64
enum Difficulty {
  easy(numbersToRemove: 16),
  medium(numbersToRemove: 32),
  hard(numbersToRemove: 48);

  const Difficulty({required this.numbersToRemove});

  final int numbersToRemove;
}
