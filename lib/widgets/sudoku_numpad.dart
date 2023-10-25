import 'package:flutter/material.dart';
import 'package:sudoku/widgets/sudoku_numpad_item.dart';

class SudokuNumPad extends StatelessWidget {
  const SudokuNumPad({super.key});

  @override
  Widget build(BuildContext context) {
    final numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];

    List<Widget> items = [];

    for (var i = 0; i < numbers.length; i++) {
      items.add(
        SudokuNumpadItem(number: numbers[i]),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: items,
      ),
    );
  }
}
