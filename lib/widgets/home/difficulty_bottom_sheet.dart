import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/sudoku_game_provider.dart';
import 'package:sudoku/utils/sudoku_utils.dart';
import 'package:sudoku/widgets/home/difficulty_item.dart';

const levels = [
  Level(title: 'Easy', difficulty: Difficulty.easy),
  Level(
    title: 'Medium',
    difficulty: Difficulty.medium,
  ),
  Level(
    title: 'Hard',
    difficulty: Difficulty.hard,
  )
];

class DifficultyBottomSheet extends ConsumerWidget {
  const DifficultyBottomSheet({super.key});

  void _startGame(Difficulty difficulty) {
    // start the game
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
          ...levels
              .map(
                (level) => DifficultyItem(
                  difficulty: level.title,
                  clickHandler: () => _startGame(level.difficulty),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
