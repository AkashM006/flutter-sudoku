import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/models/sudoku_level.dart';
import 'package:sudoku/providers/sudoku_game_provider.dart';
import 'package:sudoku/providers/sudoku_table_provider.dart';
import 'package:sudoku/widgets/common/difficulty_item.dart';

class DifficultyBottomSheet extends ConsumerWidget {
  const DifficultyBottomSheet({super.key});

  void _startGame(Difficulty difficulty, WidgetRef ref, context) {
    ref.read(sudokuTableProvider.notifier).startSudoku(
          3,
          difficulty,
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Select Difficulty",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 30,
          ),
          ...sudokuLevelMapping.entries
              .map(
                (level) => DifficultyItem(
                  difficulty: level.value.title,
                  clickHandler: () =>
                      _startGame(level.value.difficulty, ref, context),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
