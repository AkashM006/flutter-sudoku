import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/sudoku_table_provider.dart';
import 'package:sudoku/utils/general_utils.dart';
import 'package:sudoku/widgets/sudoku/sudoku_numpad_item.dart';

class SudokuNumPad extends ConsumerWidget {
  const SudokuNumPad({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> items = [];

    final expandedSudokuTable = ref.watch(sudokuTableProvider).initialState!;

    final solutionNumberMapping =
        ref.watch(sudokuTableProvider).solutionNumbersMappedToIndices!;
    final currentNumberMapping = getNumbersMappedToIndices(expandedSudokuTable);

    for (var i = 0; i < numbers.length; i++) {
      items.add(
        SudokuNumpadItem(
          number: numbers[i],
          disabled: solutionNumberMapping[i]
                  .where((element) => currentNumberMapping[i].contains(element))
                  .length ==
              9,
        ),
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
