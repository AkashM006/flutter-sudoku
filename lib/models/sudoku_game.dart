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
