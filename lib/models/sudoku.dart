import 'dart:convert';
import 'package:sudoku/providers/selected_item_provider.dart';
import 'package:sudoku/utils/general_utils.dart';

class History {
  const History({
    required this.cell,
    required this.oldValue,
    required this.newValue,
  });

  final SudokuCell cell;
  final int oldValue;
  final int newValue;

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      cell: json['cell'] != null
          ? SudokuCell.fromJson(jsonDecode(json['cell']))
          : SudokuCell(row: 0, column: 0),
      oldValue: json['oldValue'] ?? 0,
      newValue: json['newValue'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cell": json.encode(cell),
      "oldValue": oldValue,
      "newValue": newValue,
    };
  }
}

class Sudoku {
  Sudoku({
    List<List<int>>? init,
    List<List<int>>? solution,
    List<History>? history,
    List<List<int>>? origin,
  })  : initialState = init,
        solutionState = solution,
        originalUnFilledState = origin,
        historyList = history ?? [],
        solutionNumbersMappedToIndices = getNumbersMappedToIndices(solution);

  List<List<int>>? initialState;
  List<List<int>>? originalUnFilledState;
  List<List<int>>? solutionState;
  List<History> historyList = [];
  List<List<int>>? solutionNumbersMappedToIndices;

  Sudoku copyWith({init, solution, history, origin}) {
    return Sudoku(
      init: init ?? initialState,
      solution: solution ?? solutionState,
      history: history ?? historyList,
      origin: origin ?? originalUnFilledState,
    );
  }

  factory Sudoku.fromJson(Map<String, dynamic> json) {
    List<History> emptyHistory = <History>[];
    List<List<int>> emptyList = [[]];

    return Sudoku(
      init: json['init'] != null
          ? castToListOfList(jsonDecode(json['init']))
          : emptyList,
      origin: json['origin'] != null
          ? castToListOfList(jsonDecode(json['origin']))
          : emptyList,
      history: json['history'] != null
          ? castToListOfHistory(jsonDecode(json['history']))
          : emptyHistory,
      solution: json['solution'] != null
          ? castToListOfList(jsonDecode(json['solution']))
          : emptyList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "init": jsonEncode(initialState),
      "origin": jsonEncode(originalUnFilledState),
      "history": jsonEncode(historyList),
      "solution": jsonEncode(solutionState),
    };
  }
}
