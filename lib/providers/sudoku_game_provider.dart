import 'package:flutter_riverpod/flutter_riverpod.dart';

class SudokuGame {
  const SudokuGame(
      {required this.errorCount, required this.permissibleErrorCount});

  final int errorCount;
  final int permissibleErrorCount;
}

class SudokuGameNotifier extends StateNotifier<SudokuGame> {
  SudokuGameNotifier()
      : super(const SudokuGame(
          errorCount: 0,
          permissibleErrorCount: 3,
        ));

  void incrementErrorCount() {
    state = SudokuGame(
      errorCount: state.errorCount + 1,
      permissibleErrorCount: state.permissibleErrorCount,
    );
  }
}

final sudokuGameProvider =
    StateNotifierProvider<SudokuGameNotifier, SudokuGame>(
  (ref) => SudokuGameNotifier(),
);
