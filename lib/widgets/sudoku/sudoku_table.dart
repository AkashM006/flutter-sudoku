import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/sudoku_table_provider.dart';
import 'package:sudoku/utils/sudoku_utils.dart';
import 'package:sudoku/widgets/sudoku/sudoku_table_item.dart';

class SudokuTable extends ConsumerStatefulWidget {
  const SudokuTable({super.key});

  @override
  ConsumerState<SudokuTable> createState() {
    return _SudokuTableState();
  }
}

class _SudokuTableState extends ConsumerState<SudokuTable> {
  List<Widget> table = [];

  @override
  Widget build(BuildContext context) {
    final sudokuTable = ref.watch(sudokuTableProvider).initialState;

    if (sudokuTable != null) {
      table = [];
      for (var i = 0; i < sudokuTable.length; i++) {
        final row = sudokuTable[i];
        List<Widget> rowWidgets = [];
        for (var j = 0; j < row.length; j++) {
          rowWidgets.add(SudokuTableItem(
            itemValue: row[j].toString(),
            row: i,
            column: j,
          ));
        }
        table.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: rowWidgets,
        ));
      }
    }

    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          radius,
        ),
      ),
      child: Column(
        children: table,
      ),
    );
  }
}
