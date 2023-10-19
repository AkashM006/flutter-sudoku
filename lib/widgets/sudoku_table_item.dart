import 'package:flutter/material.dart';
import 'package:sudoku/utils/sudoku_utils.dart';

class SudokuTableItem extends StatefulWidget {
  const SudokuTableItem({
    super.key,
    required this.itemValue,
    required this.row,
    required this.column,
  });

  final String itemValue;
  final int row;
  final int column;

  @override
  State<StatefulWidget> createState() {
    return _SudokuTableItemState();
  }
}

class _SudokuTableItemState extends State<SudokuTableItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: SudokuUtils.getBorder(widget.row, widget.column),
          borderRadius: SudokuUtils.getBorderRadius(widget.row, widget.column),
        ),
        child: Text(
          widget.itemValue == '0' ? '' : widget.itemValue,
          textAlign: TextAlign.center,
          style: const TextStyle()
              .copyWith(fontSize: 26, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
