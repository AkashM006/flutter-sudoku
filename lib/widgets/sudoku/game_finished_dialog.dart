import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/sudoku_game_provider.dart';
import 'package:sudoku/providers/sudoku_table_provider.dart';
import 'package:sudoku/widgets/common/difficulty_bottom_sheet.dart';

class GameFinishedDialog extends ConsumerWidget {
  const GameFinishedDialog({super.key});

  void _restartGame(BuildContext context, WidgetRef ref) {
    ref.read(sudokuTableProvider.notifier).reset();
    ref.read(sudokuGameProvider.notifier).reset();
    Navigator.of(context).pop();
  }

  void _newGame(BuildContext context, WidgetRef ref) async {
    var result = await showModalBottomSheet(
      context: context,
      builder: (context) => const DifficultyBottomSheet(),
    );
    if (result == null) return;
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.read(sudokuTimeProvider);

    return AlertDialog(
      title: const Text(
        'Hooray! You did it!',
        textAlign: TextAlign.center,
      ),
      content: Text(
        "You have finished the game with a time of $time",
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () => _restartGame(context, ref),
          child: const Text("Restart"),
        ),
        TextButton(
          onPressed: () => _newGame(context, ref),
          child: const Text("New Game"),
        ),
      ],
    );
  }
}
