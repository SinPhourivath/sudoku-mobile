// Note for myself, in order for the board to have a unique solution
// it must have at least 17 clues. 81 - 17 = 64
enum Difficulty {
  easy(numbersToRemove: 30),
  medium(numbersToRemove: 48),
  hard(numbersToRemove: 64);

  const Difficulty({required this.numbersToRemove});

  final int numbersToRemove;
}
