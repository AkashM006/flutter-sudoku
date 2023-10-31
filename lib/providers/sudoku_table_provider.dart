import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/selected_item_provider.dart';

class History {
  const History({
    required this.cell,
    required this.oldValue,
    required this.newValue,
  });

  final SudokuCell cell;
  final int oldValue;
  final int newValue;
}

class Sudoku {
  Sudoku({
    init,
    solution,
    history,
  })  : initialState = init,
        solutionState = solution,
        originalUnFilledState = init,
        historyList = history ?? [];

  List<List<int>>? initialState;
  List<List<int>>? originalUnFilledState;
  List<List<int>>? solutionState;
  List<History> historyList = [];
}

class SudokuTableNotifier extends StateNotifier<Sudoku> {
  SudokuTableNotifier() : super(Sudoku());

  void setSudoku(List<List<int>> init, List<List<int>> solution) {
    List<History> history = [];
    for (var i = 0; i < init.length; i++) {
      List<bool> temp = [];
      for (var j = 0; j < init[i].length; j++) {
        if (init[i][j] == 0) {
          temp.add(true);
        } else {
          temp.add(false);
        }
      }
    }

    state = Sudoku(
      init: init,
      solution: solution,
      history: history,
    );
  }

  void setSudokuItem(int row, int column, int data) {
    if (state.initialState![row][column] != state.solutionState![row][column]) {
      // if the correct answer has not been filled with the correct answer only then fill
      var updatedHistory = [...state.historyList];
      var updatedList = List<List<int>>.from(state.initialState!);

      updatedHistory.add(
        History(
          cell: SudokuCell(row: row, column: column),
          oldValue: updatedList[row][column],
          newValue: data,
        ),
      );

      updatedList[row][column] = data;

      state = Sudoku(
        init: updatedList,
        solution: state.solutionState,
        history: updatedHistory,
      );
    }
  }

  void undo() {
    var updatedHistory = [...state.historyList];
    var updatedList = List<List<int>>.from(state.initialState!);

    if (updatedHistory.isEmpty) return;

    History lastAction = updatedHistory.removeLast();

    updatedList[lastAction.cell.row][lastAction.cell.column] =
        lastAction.oldValue;

    state = Sudoku(
      init: updatedList,
      solution: state.solutionState,
      history: updatedHistory,
    );
  }
}

final sudokuTableProvider = StateNotifierProvider<SudokuTableNotifier, Sudoku>(
  (ref) => SudokuTableNotifier(),
);
