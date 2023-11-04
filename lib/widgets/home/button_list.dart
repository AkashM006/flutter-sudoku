import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/utils/sudoku_utils.dart';
import 'package:sudoku/widgets/home/difficulty_bottom_sheet.dart';

class ButtonList extends ConsumerWidget {
  const ButtonList({super.key});

  void _newGameHandler(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const DifficultyBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _newGameHandler(context),
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
