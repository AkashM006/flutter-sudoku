import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/models/sudoku_game.dart';
import 'package:sudoku/providers/provider_keys.dart';
import 'package:sudoku/providers/shared_preference_provider.dart';
import 'package:sudoku/utils/general_utils.dart';

const oneSecond = Duration(seconds: 1);

const key = sudokuGameProviderKey;

class SudokuGameNotifier extends StateNotifier<SudokuGame> {
  final SharedPreferences sp;

  SudokuGameNotifier(this.sp)
      : super(
          sp.getString(sudokuGameProviderKey) != null
              ? SudokuGame.fromJson(
                  jsonDecode(
                    sp.getString(sudokuGameProviderKey)!,
                  ),
                )
              : const SudokuGame(
                  errorCount: 0,
                  permissibleErrorCount: 3,
                  duration: Duration.zero,
                  difficulty: Difficulty.easy,
                ),
        );

  Timer? timer;

  void init(
    int errorCount,
    int permissibleErrorCount,
    Duration duration,
    Difficulty difficulty,
  ) {
    final result = SudokuGame(
      errorCount: errorCount,
      permissibleErrorCount: permissibleErrorCount,
      duration: duration,
      difficulty: difficulty,
    );
    state = result;
    encodeAndPersist(sp, key, result);
    start();
  }

  void start() {
    timer = Timer.periodic(oneSecond, (timer) {
      final result = state.copyWith(
        duration: state.duration + oneSecond,
      );
      state = result;
      sp.setString(sudokuGameProviderKey, jsonEncode(result));
    });
  }

  void stop() {
    timer?.cancel();
  }

  void reset() {
    timer?.cancel();
    final result = state.copyWith(
      errorCount: 0,
      permissibleErrorCount: 3,
      duration: Duration.zero,
    );
    encodeAndPersist(sp, key, result);
    state = result;
    timer = Timer.periodic(oneSecond, (timer) {
      final result = state.copyWith(duration: state.duration + oneSecond);
      encodeAndPersist(sp, key, result);
      state = result;
    });
  }

  void done() {
    final result = state.copyWith(
      status: Status.done,
    );
    encodeAndPersist(sp, key, result);
    state = result;
  }

  void incrementErrorCount() {
    final result = state.copyWith(errorCount: state.errorCount + 1);
    encodeAndPersist(sp, key, result);
    state = result;
  }
}

final sudokuGameProvider =
    StateNotifierProvider<SudokuGameNotifier, SudokuGame>(
  (ref) {
    final sharedPreference = ref.watch(sharedPreferenceProvider);
    return SudokuGameNotifier(sharedPreference);
  },
);

final sudokuTimeProvider = Provider<String>((ref) {
  final duration = ref.watch(sudokuGameProvider).duration;
  return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
});
