import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/models/sudoku_level.dart';

const oneSecond = Duration(seconds: 1);

enum Difficulty {
  easy,
  medium,
  hard,
}

class SudokuGame {
  const SudokuGame({
    required this.errorCount,
    required this.permissibleErrorCount,
    required this.duration,
    required this.difficulty,
  });

  final int errorCount;
  final int permissibleErrorCount;
  final SudokuLevel difficulty;

  final Duration duration;

  SudokuGame copyWith({
    errorCount,
    permissibleErrorCount,
    duration,
    difficulty,
  }) {
    return SudokuGame(
      errorCount: errorCount ?? this.errorCount,
      permissibleErrorCount:
          permissibleErrorCount ?? this.permissibleErrorCount,
      duration: duration ?? this.duration,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}

class SudokuGameNotifier extends StateNotifier<SudokuGame> {
  SudokuGameNotifier()
      : super(
          SudokuGame(
            errorCount: 0,
            permissibleErrorCount: 3,
            duration: Duration.zero,
            difficulty: sudokuLevelMapping[Difficulty.easy]!,
          ),
        );

  Timer? timer;

  void init(
    int errorCount,
    int permissibleErrorCount,
    Duration duration,
    SudokuLevel difficulty,
  ) {
    state = SudokuGame(
      errorCount: errorCount,
      permissibleErrorCount: permissibleErrorCount,
      duration: duration,
      difficulty: difficulty,
    );
    start();
  }

  void start() {
    timer = Timer.periodic(oneSecond, (timer) {
      state = state.copyWith(
        duration: state.duration + oneSecond,
      );
    });
  }

  void stop() {
    timer?.cancel();
  }

  void reset() {
    timer?.cancel();
    state = state.copyWith(
      errorCount: 0,
      permissibleErrorCount: 3,
      duration: Duration.zero,
    );
    timer = Timer.periodic(oneSecond, (timer) {
      state = state.copyWith(duration: state.duration + oneSecond);
    });
  }

  void incrementErrorCount() {
    state = state.copyWith(errorCount: state.errorCount + 1);
  }
}

final sudokuGameProvider =
    StateNotifierProvider<SudokuGameNotifier, SudokuGame>(
  (ref) {
    return SudokuGameNotifier();
  },
);

final sudokuTimeProvider = Provider<String>((ref) {
  final duration = ref.watch(sudokuGameProvider).duration;
  return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
});
