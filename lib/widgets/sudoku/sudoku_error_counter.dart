import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/sudoku_game_provider.dart';
import 'package:sudoku/providers/sudoku_table_provider.dart';
import 'package:sudoku/widgets/sudoku/game_finished_dialog.dart';
import 'package:sudoku/widgets/sudoku/game_over_dialog.dart';

class SudokuErrorCounter extends ConsumerStatefulWidget {
  const SudokuErrorCounter({super.key});

  @override
  ConsumerState<SudokuErrorCounter> createState() {
    return _SudokuErrorCounterState();
  }
}

class _SudokuErrorCounterState extends ConsumerState<SudokuErrorCounter> {
  @override
  void initState() {
    super.initState();
    removeErrorStateCheckListener =
        ref.read(sudokuGameProvider.notifier).addListener((state) {
      // listen if mistakes become 3
      if (state.errorCount >= state.permissibleErrorCount) {
        ref.read(sudokuGameProvider.notifier).stop();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const GameOverDialog(),
        );
      }
    });

    removeFilledStateCheckListener =
        ref.read(sudokuTableProvider.notifier).addListener((state) {
      // listen if the sudoku has been filled
      final currentTable = state.initialState!.expand((row) => row).toList();
      final solutionTable = state.solutionState!.expand((row) => row).toList();

      final hasNotFinished = currentTable.contains(0);

      if (hasNotFinished) {
        return;
      }

      final isFilledCorrectly = listEquals(currentTable, solutionTable);

      if (!isFilledCorrectly) return;

      ref.read(sudokuGameProvider.notifier).stop();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const GameFinishedDialog(),
      );
    });
  }

  Function? removeErrorStateCheckListener;
  Function? removeFilledStateCheckListener;

  @override
  void dispose() {
    super.dispose();
    removeErrorStateCheckListener?.call();
    removeFilledStateCheckListener?.call();
  }

  @override
  Widget build(BuildContext context) {
    final userErrors = ref.watch(sudokuGameProvider).errorCount;
    final permissibleErrors =
        ref.watch(sudokuGameProvider).permissibleErrorCount;

    return Text("Mistakes: $userErrors/$permissibleErrors");
  }
}
