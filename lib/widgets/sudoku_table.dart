import 'package:flutter/material.dart';
import 'package:sudoku/data/sudoku_data.dart';
import 'package:sudoku/widgets/sudoku_table_item.dart';

class SudokuTable extends StatefulWidget {
  const SudokuTable({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SudokuTableState();
  }
}

class _SudokuTableState extends State<SudokuTable> {
  final _sudokuData = sudokuWithoutAnswer;

  List<Widget> table = [];

  @override
  Widget build(BuildContext context) {
    table = [];
    for (var i = 0; i < _sudokuData.length; i++) {
      final row = _sudokuData[i];
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

    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        children: table,
      ),
    );
  }
}
