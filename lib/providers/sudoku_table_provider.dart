import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/models/sudoku.dart';
import 'package:sudoku/models/sudoku_game.dart';
import 'package:sudoku/models/sudoku_level.dart';
import 'package:sudoku/providers/provider_keys.dart';
import 'package:sudoku/providers/selected_item_provider.dart';
import 'package:sudoku/providers/shared_preference_provider.dart';
import 'package:sudoku/providers/sudoku_game_provider.dart';
import 'package:sudoku/utils/general_utils.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

const key = sudokuTableProviderKey;

class SudokuTableNotifier extends StateNotifier<Sudoku> {
  SudokuTableNotifier(
    this.sp,
    this.errorCountIncrementer,
    this.initGame,
  ) : super(
          sp.getString(sudokuTableProviderKey) != null
              ? Sudoku.fromJson(
                  jsonDecode(
                    sp.getString(sudokuTableProviderKey)!,
                  ),
                )
              : Sudoku(),
        );

  final SharedPreferences sp;
  final Function() errorCountIncrementer;
  final Function(
    int errorCount,
    int permissibleErrorCount,
    Duration duration,
    Difficulty difficulty,
  ) initGame;

  void startSudoku(
    int permissibleErrorCount,
    Difficulty difficulty,
  ) {
    // method start the sudoku
    final sudokuLevel = sudokuLevelMapping[difficulty]!;
    final missingNumbers = sudokuLevel.min +
        Random().nextInt(sudokuLevel.max - sudokuLevel.min + 1);

    var sudokuGenerator = SudokuGenerator(emptySquares: missingNumbers);

    List<List<int>> question = sudokuGenerator.newSudoku;
    List<List<int>> answer = sudokuGenerator.newSudokuSolved;

    final result = Sudoku(
      init: question.map((e) => [...e]).toList(),
      solution: answer.map((e) => [...e]).toList(),
      history: <History>[],
      origin: question.map((e) => [...e]).toList(),
    );

    encodeAndPersist(
      sp,
      key,
      result,
    );
    state = result;

    initGame(0, 3, Duration.zero, difficulty);
  }

  void setSudokuItem(int row, int column, int data) {
    // method used to set a sudoku cell item
    if (state.initialState![row][column] != state.solutionState![row][column]) {
      var updatedHistory = [...state.historyList];
      var updatedList = state.initialState!
          .map(
            (row) => [...row],
          )
          .toList();

      if (data != 0 &&
          updatedList[row][column] != data &&
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

      final result = state.copyWith(init: updatedList, history: updatedHistory);
      encodeAndPersist(sp, key, result);
      state = result;
    }
  }

  void undo() {
    // method used to undo
    var updatedHistory = [...state.historyList];
    var updatedList = state.initialState!.map((row) => [...row]).toList();

    if (updatedHistory.isEmpty) return;

    History lastAction = updatedHistory.removeLast();

    updatedList[lastAction.cell.row][lastAction.cell.column] =
        lastAction.oldValue;

    final result = state.copyWith(init: updatedList, history: updatedHistory);

    encodeAndPersist(sp, key, result);

    state = result;
  }

  void reset() {
    // method used to reset the sudoku state to start
    final result = Sudoku(
      history: <History>[],
      init: state.originalUnFilledState,
      origin: state.originalUnFilledState,
      solution: state.solutionState,
    );
    encodeAndPersist(sp, key, result);
    state = result;
  }
}

final sudokuTableProvider = StateNotifierProvider<SudokuTableNotifier, Sudoku>(
  (ref) {
    final sudokuGame = ref.read(sudokuGameProvider.notifier);
    final errorCountIncrementer = sudokuGame.incrementErrorCount;
    final initGame = sudokuGame.init;
    final sp = ref.watch(sharedPreferenceProvider);

    return SudokuTableNotifier(sp, errorCountIncrementer, initGame);
  },
);
