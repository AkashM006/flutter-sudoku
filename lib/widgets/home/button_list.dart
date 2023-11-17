import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/models/sudoku_game.dart';
import 'package:sudoku/models/sudoku_level.dart';
import 'package:sudoku/providers/sudoku_game_provider.dart';
import 'package:sudoku/screens/sudoku.dart';
import 'package:sudoku/utils/sudoku_utils.dart';
import 'package:sudoku/widgets/common/difficulty_bottom_sheet.dart';

class ButtonList extends ConsumerWidget {
  const ButtonList({super.key});

  void _newGameHandler(context, WidgetRef ref) async {
    var result = await showModalBottomSheet(
      context: context,
      builder: (context) => const DifficultyBottomSheet(),
    );
    if (result == null) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SudokuScreen(),
      ),
    );
    ref.read(sudokuGameProvider.notifier).stop();
  }

  void _continueHandler(context, WidgetRef ref) async {
    ref.read(sudokuGameProvider.notifier).start();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SudokuScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sudokuGame = ref.watch(sudokuGameProvider);
    final didGameExist = sudokuGame.duration.inMilliseconds != 0 &&
        sudokuGame.status == Status.pending;
    final sudokuGameDifficulty = ref.watch(sudokuGameProvider).difficulty;
    final gameDifficultyName = sudokuLevelMapping[sudokuGameDifficulty]!.title;
    final sudokuDisplayTime = ref.watch(sudokuTimeProvider);

    List<Widget> children = [];

    if (didGameExist) {
      children.add(
        ElevatedButton(
          onPressed: () => _continueHandler(context, ref),
          style: ElevatedButton.styleFrom(
            backgroundColor: customBackgroundColor,
            padding: const EdgeInsets.all(15),
          ),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.play_arrow,
                    color: customTextColor,
                  ),
                  Text(
                    "Continue - $gameDifficultyName",
                    style: const TextStyle(
                      fontSize: 16,
                      color: customTextColor,
                    ),
                  ),
                ],
              ),
              Text(
                sudokuDisplayTime,
                style: const TextStyle(
                  fontSize: 16,
                  color: customTextColor,
                ),
              ),
            ],
          ),
        ),
      );

      children.add(
        TextButton.icon(
          icon: const Icon(
            Icons.add,
            color: customTextColor,
          ),
          onPressed: () => _newGameHandler(context, ref),
          label: const Text(
            'New Game',
            style: TextStyle(
              fontSize: 14,
              color: customTextColor,
            ),
          ),
        ),
      );
    } else {
      children.add(
        ElevatedButton.icon(
          icon: const Icon(
            Icons.add,
            color: customTextColor,
          ),
          onPressed: () => _newGameHandler(context, ref),
          style: ElevatedButton.styleFrom(
            backgroundColor: customBackgroundColor,
          ),
          label: const Text(
            "New Game",
            style: TextStyle(
              fontSize: 16,
              color: customTextColor,
            ),
          ),
        ),
      );
    }

    return Column(
      children: children,
    );
  }
}
