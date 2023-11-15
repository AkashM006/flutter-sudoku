import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/providers/provider_keys.dart';
import 'package:sudoku/providers/shared_preference_provider.dart';

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
  final Difficulty difficulty;

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

  factory SudokuGame.fromJson(Map<String, dynamic> json) {
    return SudokuGame(
      errorCount: json['errorCount'] ?? 3,
      permissibleErrorCount: json['permissibleErrorCount'] ?? 0,
      duration: json['duration'] != null
          ? Duration(milliseconds: json['duration'])
          : Duration.zero,
      difficulty: json['difficulty'] != null
          ? Difficulty.values.elementAt(json['difficulty'])
          : Difficulty.easy,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "errorCount": errorCount,
      'permissibleErrorCount': permissibleErrorCount,
      "duration": duration.inMilliseconds,
      "difficulty": difficulty.index,
    };
  }
}

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
                  // difficulty: sudokuLevelMapping[Difficulty.easy]!,
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
    final result = state.copyWith(errorCount: state.errorCount + 1);
    sp.setString(sudokuGameProviderKey, jsonEncode(result));
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
