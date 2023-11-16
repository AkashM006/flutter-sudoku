import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sudoku/models/sudoku.dart';
import 'package:sudoku/providers/selected_item_provider.dart';
import 'package:sudoku/providers/sudoku_table_provider.dart';
import 'package:sudoku/widgets/sudoku/animated_rive_button.dart';

class SudokuActions extends ConsumerStatefulWidget {
  const SudokuActions({super.key});

  @override
  ConsumerState<SudokuActions> createState() {
    return _SudokuActionsState();
  }
}

class _SudokuActionsState extends ConsumerState<SudokuActions> {
  late RiveAnimationController _eraseController;
  late RiveAnimationController _undoController;

  @override
  void initState() {
    super.initState();
    _eraseController = OneShotAnimation('erase', autoplay: false);
    _undoController = OneShotAnimation('undo', autoplay: false);
  }

  void _handleErase() {
    // erase only cells which are not filled correctly
    // when erasing add to history
    SudokuCell selectedCell = ref.read(selectedItemProvider);
    Sudoku sudoku = ref.read(sudokuTableProvider);

    if (sudoku.initialState![selectedCell.row][selectedCell.column] ==
            sudoku.solutionState![selectedCell.row][selectedCell.column] ||
        sudoku.initialState![selectedCell.row][selectedCell.column] == 0) {
      return;
    }
    if (!_eraseController.isActive) _eraseController.isActive = true;
    ref.read(sudokuTableProvider.notifier).setSudokuItem(
          selectedCell.row,
          selectedCell.column,
          0,
        );
  }

  void _handleUndo() {
    if (!_undoController.isActive) _undoController.isActive = true;
    // using the History class, undo any action till it is empty
    // undo should also include the erased one
    ref.read(sudokuTableProvider.notifier).undo();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AnimatedRiveButton(
            onTap: _handleErase,
            animatedChild: RiveAnimation.asset(
              'assets/eraser.riv',
              alignment: Alignment.center,
              fit: BoxFit.contain,
              controllers: [_eraseController],
            ),
            title: 'Erase',
          ),
          AnimatedRiveButton(
            onTap: _handleUndo,
            animatedChild: RiveAnimation.asset(
              'assets/undo.riv',
              alignment: Alignment.center,
              fit: BoxFit.contain,
              controllers: [_undoController],
            ),
            title: 'Undo',
          ),
        ],
      ),
    );
  }
}
