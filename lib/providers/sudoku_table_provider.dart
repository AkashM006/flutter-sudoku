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
  Sudoku({init, solution, history})
      : initialState = init,
        solutionState = solution;

  List<List<int>>? initialState;
  List<List<int>>? solutionState;
  List<History> history = [];
}

class SudokuTableNotifier extends StateNotifier<Sudoku> {
  SudokuTableNotifier() : super(Sudoku());

  void setSudoku(List<List<int>> init, List<List<int>> solution) {
    state = Sudoku(init: init, solution: solution);
  }

  void setSudokuItem(int row, int column, int data) {
    final updatedList = List<List<int>>.from(state.initialState!);
    updatedList[row][column] = data;
    state = Sudoku(
      init: updatedList,
      solution: state.solutionState,
      history: state.history,
    );
    // state.initialState = [...updatedList];
  }
}

final sudokuTableProvider = StateNotifierProvider<SudokuTableNotifier, Sudoku>(
  (ref) => SudokuTableNotifier(),
);
