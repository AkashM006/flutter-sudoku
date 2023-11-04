import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/sudoku_game_provider.dart';
import 'package:sudoku/providers/sudoku_table_provider.dart';
import 'package:sudoku/widgets/sudoku/sudoku_actions.dart';
import 'package:sudoku/widgets/sudoku/sudoku_error_counter.dart';
import 'package:sudoku/widgets/sudoku/sudoku_numpad.dart';
import 'package:sudoku/widgets/sudoku/sudoku_table.dart';

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
    Future(() {
      ref.read(sudokuGameProvider.notifier).start(); // start the timer
    });
  }

  @override
  Widget build(BuildContext context) {
    final table = ref.watch(sudokuTableProvider).initialState;
    final sudokuTime = ref.watch(sudokuTimeProvider);
    final sudokuLevel = ref.watch(sudokuGameProvider).difficulty.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku - $sudokuLevel'),
        centerTitle: true,
      ),
      body: table == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(sudokuTime),
                          const SudokuErrorCounter(),
                        ],
                      ),
                    ),
                    const SudokuTable(),
                    const SizedBox(
                      height: 20,
                    ),
                    const SudokuActions(),
                    const SizedBox(
                      height: 20,
                    ),
                    const SudokuNumPad(),
                  ],
                ),
              ),
            ),
    );
  }
}
