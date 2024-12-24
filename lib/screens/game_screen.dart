import 'package:flutter/material.dart';
import '../models/difficulity_model.dart';
import '../utils/board_generator.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.difficulity});
  final Difficulity difficulity;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<int>> grid = List.generate(9, (_) => List.generate(9, (_) => 0));
  late SudokuGenerator sudokuGenerator;

  @override
  void initState() {
    super.initState();
    sudokuGenerator = SudokuGenerator();
    sudokuGenerator.generateValidBoard();
    sudokuGenerator.removeNumbers(widget.difficulity.numberToRemove);

    _populateGrid();
  }

  // Transfer game board to the grid
  void _populateGrid() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
          grid[i][j] = sudokuGenerator.board[i][j] == 0 ? 0 : sudokuGenerator.board[i][j];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sudoku Game")),
      body: Column(
        children: [
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
                    setState(() {
                      // Only allow changes in the cells that are not already filled
                      if (grid[row][col] == 0) {
                        grid[row][col] = detail.data;
                      }
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: grid[row][col] != 0
                            ? Colors.blue.shade100
                            : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          grid[row][col] != 0 ? grid[row][col].toString() : '',
                          style: TextStyle(fontSize: 16),
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
    );
  }
}

class NumberCard extends StatelessWidget {
  final int number;
  final bool isDragging;

  const NumberCard({super.key, required this.number, this.isDragging = false});

  @override
  Widget build(BuildContext context) {
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
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
