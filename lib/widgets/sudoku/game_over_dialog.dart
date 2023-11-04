import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/sudoku_game_provider.dart';
import 'package:sudoku/providers/sudoku_table_provider.dart';

class GameOverDialog extends ConsumerWidget {
  const GameOverDialog({super.key});

  void _restartGame(BuildContext context, WidgetRef ref) {
    ref.read(sudokuTableProvider.notifier).reset();
    ref.read(sudokuGameProvider.notifier).reset();
    Navigator.of(context).pop('restart_game');
  }

  void _newGame(BuildContext context, WidgetRef ref) {
    final currentDifficulty =
        ref.read(sudokuGameProvider).difficulty.difficulty;
    ref.read(sudokuTableProvider.notifier).startSudoku(3, currentDifficulty);
    Navigator.of(context).pop('new_game');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.read(sudokuTimeProvider);

    return AlertDialog(
      title: const Text(
        'Game over',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Time Taken: $time'),
          const Text(
            "Whoops! The game is over because you have made 3 mistakes.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
            onPressed: () => _restartGame(context, ref),
            child: const Text("Restart")),
        TextButton(
            onPressed: () => _newGame(context, ref),
            child: const Text("New Game")),
      ],
    );
  }
}
