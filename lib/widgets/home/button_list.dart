import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/sudoku_game_provider.dart';
import 'package:sudoku/screens/sudoku.dart';
import 'package:sudoku/utils/sudoku_utils.dart';
import 'package:sudoku/widgets/common/difficulty_bottom_sheet.dart';

class ButtonList extends ConsumerWidget {
  const ButtonList({super.key});

  void _newGameHandler(context, WidgetRef ref) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => const DifficultyBottomSheet(),
    );
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SudokuScreen(),
      ),
    );
    ref.read(sudokuGameProvider.notifier).stop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _newGameHandler(context, ref),
          style: ElevatedButton.styleFrom(
            backgroundColor: neighboringColor,
            foregroundColor: selectedTextColor,
          ),
          child: const Text('New Game'),
        ),
      ],
    );
  }
}
