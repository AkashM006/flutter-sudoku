import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/data/sudoku_data.dart';
import 'package:sudoku/providers/sudoku_table_provider.dart';
import 'package:sudoku/widgets/sudoku_actions.dart';
import 'package:sudoku/widgets/sudoku_error_counter.dart';
import 'package:sudoku/widgets/sudoku_numpad.dart';
import 'package:sudoku/widgets/sudoku_table.dart';
import 'package:sudoku/widgets/sudoku_timer.dart';

class SudokuScreen extends ConsumerStatefulWidget {
  const SudokuScreen({super.key});

  @override
  ConsumerState<SudokuScreen> createState() {
    return _SudokuScreenState();
  }
}

class _SudokuScreenState extends ConsumerState<SudokuScreen> {
  @override
  void initState() {
    super.initState();
    final init = List<List<int>>.from(sudokuWithoutSolution);
    final solution = List<List<int>>.from(sudokuWithSolution);
    Future(() {
      ref.read(sudokuTableProvider.notifier).setSudoku(
            init,
            solution,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final table = ref.watch(sudokuTableProvider).initialState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku - Hard'),
        centerTitle: true,
      ),
      body: table == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SudokuTimer(),
                          SudokuErrorCounter(),
                        ],
                      ),
                    ),
                    SudokuTable(),
                    SizedBox(
                      height: 20,
                    ),
                    SudokuActions(),
                    SizedBox(
                      height: 20,
                    ),
                    SudokuNumPad(),
                  ],
                ),
              ),
            ),
    );
  }
}
