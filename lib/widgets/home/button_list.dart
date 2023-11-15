import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void _continueHandler(context, WidgetRef ref) async {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sudokuGameTime = ref.watch(sudokuGameProvider).duration;
    final didGameExist = sudokuGameTime.inMilliseconds != 0;

    print('Game: $didGameExist');

    List<Widget> children = [];

    if (didGameExist) {
      children.add(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: neighboringColor,
            foregroundColor: selectedTextColor,
          ),
          onPressed: () => _continueHandler(context, ref),
          child: const Text("Continue"),
        ),
      );

      children.add(
        ElevatedButton(
          onPressed: () => _newGameHandler(context, ref),
          child: const Text('New Game'),
        ),
      );
    } else {
      children.add(
        ElevatedButton(
          onPressed: () => _newGameHandler(context, ref),
          style: ElevatedButton.styleFrom(
            backgroundColor: neighboringColor,
            foregroundColor: selectedTextColor,
          ),
          child: const Text('New Game'),
        ),
      );
    }

    return Column(
      children: children,
    );
  }
}
