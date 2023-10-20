import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/selected_item_provider.dart';
import 'package:sudoku/utils/sudoku_utils.dart';

class SudokuTableItem extends ConsumerStatefulWidget {
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
  ConsumerState<SudokuTableItem> createState() {
    return _SudokuTableItemState();
  }
}

class _SudokuTableItemState extends ConsumerState<SudokuTableItem> {
  void _touchHandler() {
    ref
        .read(selectedItemProvider.notifier)
        .setSelected(widget.row, widget.column);
  }

  @override
  Widget build(BuildContext context) {
    final selectedCell = ref.watch(selectedItemProvider);

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: SudokuUtils.getCellBackground(
              widget.row, widget.column, selectedCell),
          borderRadius: SudokuUtils.getBorderRadius(widget.row, widget.column),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _touchHandler,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                border: SudokuUtils.getBorder(widget.row, widget.column),
                borderRadius:
                    SudokuUtils.getBorderRadius(widget.row, widget.column),
              ),
              child: Text(
                widget.itemValue == '0' ? '' : widget.itemValue,
                textAlign: TextAlign.center,
                style: const TextStyle().copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                  color: SudokuUtils.getCellTextColor(
                    widget.row,
                    widget.column,
                    selectedCell,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
