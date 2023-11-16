import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/models/sudoku_level.dart';
import 'package:sudoku/providers/sudoku_game_provider.dart';
import 'package:sudoku/widgets/sudoku/sudoku_actions.dart';
import 'package:sudoku/widgets/sudoku/sudoku_error_counter.dart';
import 'package:sudoku/widgets/sudoku/sudoku_numpad.dart';
import 'package:sudoku/widgets/sudoku/sudoku_table.dart';

class SudokuScreen extends ConsumerWidget {
  const SudokuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sudokuTime = ref.watch(sudokuTimeProvider);
    final sudokudiff = ref.watch(sudokuGameProvider).difficulty;
    final sudokuLevel = sudokuLevelMapping[sudokudiff]!.title;

    return WillPopScope(
      onWillPop: () async {
        ref.read(sudokuGameProvider.notifier).stop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sudoku - $sudokuLevel'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(sudokuTime),
                      const SudokuErrorCounter(),
                    ],
                  ),
                ),
                const SudokuTable(),
                const SizedBox(
                  height: 20,
                ),
                const SudokuActions(),
                const SizedBox(
                  height: 20,
                ),
                const SudokuNumPad(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
