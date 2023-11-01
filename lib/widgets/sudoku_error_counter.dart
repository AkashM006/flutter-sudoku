import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/sudoku_game_provider.dart';
import 'package:sudoku/widgets/game_over_dialog.dart';

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
    ref.read(sudokuGameProvider.notifier).addListener((state) async {
      if (state.errorCount >= state.permissibleErrorCount) {
        ref.read(sudokuGameProvider.notifier).stop();
        await showDialog(
          context: context,
          builder: (context) => const GameOverDialog(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userErrors = ref.watch(sudokuGameProvider).errorCount;
    final permissibleErrors =
        ref.watch(sudokuGameProvider).permissibleErrorCount;

    return Text("Mistakes: $userErrors/$permissibleErrors");
  }
}
