import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/selected_item_provider.dart';
import 'package:sudoku/providers/sudoku_table_provider.dart';
import 'package:sudoku/utils/sudoku_utils.dart';

class SudokuNumpadItem extends ConsumerWidget {
  const SudokuNumpadItem({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValues = ref.watch(selectedItemProvider);

    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Material(
          color: neighboringColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          elevation: 3,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            splashColor: selectedColor,
            onTap: () {
              ref.read(sudokuTableProvider.notifier).setSudokuItem(
                  selectedValues.row, selectedValues.column, number);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                number.toString(),
                style: const TextStyle().copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
