import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/selected_item_provider.dart';
import 'package:sudoku/providers/sudoku_game_provider.dart';

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
    origin,
  })  : initialState = init,
        solutionState = solution,
        originalUnFilledState = origin,
        historyList = history ?? [];

  List<List<int>>? initialState;
  List<List<int>>? originalUnFilledState;
  List<List<int>>? solutionState;
  List<History> historyList = [];

  Sudoku copyWith({init, solution, history, origin}) {
    return Sudoku(
      init: init ?? initialState,
      solution: solution ?? solutionState,
      history: history ?? historyList,
      origin: origin ?? originalUnFilledState,
    );
  }
}

class SudokuTableNotifier extends StateNotifier<Sudoku> {
  SudokuTableNotifier(this.errorCountIncrementer) : super(Sudoku());

  final Function() errorCountIncrementer;

  void setSudoku(
    List<List<int>> init,
    List<List<int>> solution,
  ) {
    List<History> history = [];

    state = Sudoku(
      init: init,
      solution: solution,
      origin: init.map((row) => [...row]).toList(),
      history: history,
    );
  }

  void setSudokuItem(int row, int column, int data) {
    if (state.initialState![row][column] != state.solutionState![row][column]) {
      // if the correct answer has not been filled only then fill
      var updatedHistory = [...state.historyList];
      var updatedList = state.initialState!
          .map(
            (row) => [...row],
          )
          .toList();

      if (updatedList[row][column] != data &&
          data != state.solutionState![row][column]) {
        // if user enters something wrong then increment the error count
        errorCountIncrementer();
      }

      updatedHistory.add(
        History(
          cell: SudokuCell(row: row, column: column),
          oldValue: updatedList[row][column],
          newValue: updatedList[row][column] == data ? 0 : data,
        ),
      );
      updatedList[row][column] = updatedList[row][column] == data ? 0 : data;

      state = state.copyWith(init: updatedList, history: updatedHistory);
    }
  }

  void undo() {
    var updatedHistory = [...state.historyList];
    var updatedList = state.initialState!.map((row) => [...row]).toList();

    if (updatedHistory.isEmpty) return;

    History lastAction = updatedHistory.removeLast();

    updatedList[lastAction.cell.row][lastAction.cell.column] =
        lastAction.oldValue;

    state = state.copyWith(init: updatedList, history: updatedHistory);
  }

  void reset() {
    state = Sudoku(
      history: <History>[],
      init: state.originalUnFilledState,
      origin: state.originalUnFilledState,
      solution: state.solutionState,
    );
  }
}

final sudokuTableProvider = StateNotifierProvider<SudokuTableNotifier, Sudoku>(
  (ref) {
    final errorCountIncrementer =
        ref.read(sudokuGameProvider.notifier).incrementErrorCount;

    return SudokuTableNotifier(errorCountIncrementer);
  },
);
