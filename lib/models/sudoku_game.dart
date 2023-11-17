enum Difficulty {
  easy,
  medium,
  hard,
}

enum Status {
  pending,
  done,
}

class SudokuGame {
  const SudokuGame({
    required this.errorCount,
    required this.permissibleErrorCount,
    required this.duration,
    required this.difficulty,
    this.status = Status.pending,
  });

  final int errorCount;
  final int permissibleErrorCount;
  final Difficulty difficulty;

  final Duration duration;
  final Status status;

  SudokuGame copyWith({
    errorCount,
    permissibleErrorCount,
    duration,
    difficulty,
    status,
  }) {
    return SudokuGame(
      errorCount: errorCount ?? this.errorCount,
      permissibleErrorCount:
          permissibleErrorCount ?? this.permissibleErrorCount,
      duration: duration ?? this.duration,
      difficulty: difficulty ?? this.difficulty,
      status: status ?? this.status,
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
      status: json['status'] != null
          ? Status.values.elementAt(json['status'])
          : Status.pending,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "errorCount": errorCount,
      'permissibleErrorCount': permissibleErrorCount,
      "duration": duration.inMilliseconds,
      "difficulty": difficulty.index,
      "status": status.index,
    };
  }
}
