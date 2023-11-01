import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const oneSecond = Duration(seconds: 1);

class SudokuGame {
  const SudokuGame({
    required this.errorCount,
    required this.permissibleErrorCount,
    required this.duration,
  });

  final int errorCount;
  final int permissibleErrorCount;

  final Duration duration;

  SudokuGame copyWith({errorCount, permissibleErrorCount, duration}) {
    return SudokuGame(
      errorCount: errorCount ?? this.errorCount,
      permissibleErrorCount:
          permissibleErrorCount ?? this.permissibleErrorCount,
      duration: duration ?? this.duration,
    );
  }
}

class SudokuGameNotifier extends StateNotifier<SudokuGame> {
  SudokuGameNotifier()
      : super(
          const SudokuGame(
            errorCount: 0,
            permissibleErrorCount: 3,
            duration: Duration.zero,
          ),
        );

  Timer? timer;

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
    state = const SudokuGame(
      errorCount: 0,
      permissibleErrorCount: 3,
      duration: Duration(seconds: 0),
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
  (ref) => SudokuGameNotifier(),
);

final sudokuTimeProvider = Provider<String>((ref) {
  final duration = ref.watch(sudokuGameProvider).duration;
  return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
});
