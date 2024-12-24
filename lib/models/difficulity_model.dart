// Note for myself, in order for the board to have a unique solution
// it must have at least 17 clues. 81 - 17 = 64
enum Difficulity {
  easy(numberToRemove: 30),
  medium(numberToRemove: 48),
  hard(numberToRemove: 64);

  const Difficulity({required this.numberToRemove});

  final int numberToRemove;
}
