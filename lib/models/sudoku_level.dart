import 'package:sudoku/providers/sudoku_game_provider.dart';

class SudokuLevel {
  const SudokuLevel({
    required this.title,
    required this.difficulty,
    required this.min,
    required this.max,
  });

  final String title;
  final Difficulty difficulty;
  final int min;
  final int max;
}

const Map<Difficulty, SudokuLevel> sudokuLevelMapping = {
  Difficulty.easy: SudokuLevel(
    title: 'Easy',
    difficulty: Difficulty.easy,
    min: 10,
    max: 25,
  ),
  Difficulty.medium: SudokuLevel(
    title: 'Medium',
    difficulty: Difficulty.medium,
    min: 35,
    max: 45,
  ),
  Difficulty.hard: SudokuLevel(
    title: 'Hard',
    difficulty: Difficulty.hard,
    min: 50,
    max: 55,
  ),
};
