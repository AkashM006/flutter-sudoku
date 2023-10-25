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
  Sudoku({init, solution, history, editable})
      : initialState = init,
        solutionState = solution,
        editableState = editable;

  List<List<int>>? initialState;
  List<List<int>>? solutionState;
  List<List<bool>>? editableState;
  List<History> history = [];
}

class SudokuTableNotifier extends StateNotifier<Sudoku> {
  SudokuTableNotifier() : super(Sudoku());

  void setSudoku(List<List<int>> init, List<List<int>> solution) {
    List<List<bool>> editable = [];
    for (var i = 0; i < init.length; i++) {
      List<bool> temp = [];
      for (var j = 0; j < init[i].length; j++) {
        if (init[i][j] == 0) {
          temp.add(true);
        } else {
          temp.add(false);
        }
      }
      editable.add(temp);
    }

    state = Sudoku(init: init, solution: solution, editable: editable);
  }

  void setSudokuItem(int row, int column, int data) {
    if (state.editableState![row][column]) {
      // if the correct answer has not been filled with the correct answer only then fill
      var updatedList = List<List<int>>.from(state.initialState!);
      updatedList[row][column] = data;
      var editableUpdatedList = List<List<bool>>.from(state.editableState!);

      if (state.solutionState![row][column] == data) {
        editableUpdatedList[row][column] = false;
      }

      state = Sudoku(
        init: updatedList,
        solution: state.solutionState,
        history: state.history,
        editable: editableUpdatedList,
      );
    }
  }
}

final sudokuTableProvider = StateNotifierProvider<SudokuTableNotifier, Sudoku>(
  (ref) => SudokuTableNotifier(),
);
