import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/models/sudoku_level.dart';
import 'package:sudoku/providers/selected_item_provider.dart';
import 'package:sudoku/providers/sudoku_game_provider.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

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
  SudokuTableNotifier(this.errorCountIncrementer, this.initGame)
      : super(Sudoku());

  final Function() errorCountIncrementer;
  final Function(
    int errorCount,
    int permissibleErrorCount,
    Duration duration,
    SudokuLevel difficulty,
  ) initGame;

  void startSudoku(
    int permissibleErrorCount,
    Difficulty difficulty,
  ) {
    final sudokuLevel = sudokuLevelMapping[difficulty]!;
    final missingNumbers = sudokuLevel.min +
        Random().nextInt(sudokuLevel.max - sudokuLevel.min + 1);

    var sudokuGenerator = SudokuGenerator(emptySquares: missingNumbers);

    List<List<int>> question = sudokuGenerator.newSudoku;
    List<List<int>> answer = sudokuGenerator.newSudokuSolved;

    state = Sudoku(
      init: question.map((e) => [...e]).toList(),
      solution: answer.map((e) => [...e]).toList(),
      history: <History>[],
      origin: question.map((e) => [...e]).toList(),
    );

    initGame(0, 3, Duration.zero, sudokuLevel);
  }

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
      var updatedHistory = [...state.historyList];
      var updatedList = state.initialState!
          .map(
            (row) => [...row],
          )
          .toList();

      if (updatedList[row][column] != data &&
          data != state.solutionState![row][column]) {
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
    final sudokuGame = ref.read(sudokuGameProvider.notifier);
    final errorCountIncrementer = sudokuGame.incrementErrorCount;
    final initGame = sudokuGame.init;

    return SudokuTableNotifier(errorCountIncrementer, initGame);
  },
);
