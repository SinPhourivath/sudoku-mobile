import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<int?>> grid =
      List.generate(9, (_) => List.generate(9, (_) => null));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 9,
              ),
              itemCount: 81,
              itemBuilder: (context, index) {
                final row = index ~/ 9;
                final col = index % 9;
                return DragTarget<int>(
                  onAcceptWithDetails: (detail) {
                    setState(() {
                      grid[row][col] = detail.data;
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: grid[row][col] != null
                            ? Colors.blue.shade100
                            : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          grid[row][col]?.toString() ?? '',
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
