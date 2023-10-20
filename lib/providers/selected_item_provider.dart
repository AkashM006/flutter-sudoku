import 'package:flutter_riverpod/flutter_riverpod.dart';

class SudokuCell {
  SudokuCell({required this.row, required this.column});
  final int row, column;
}

class SelectedItemNotifier extends StateNotifier<SudokuCell> {
  SelectedItemNotifier() : super(SudokuCell(row: 0, column: 0));

  void setSelected(int row, int column) {
    state = SudokuCell(row: row, column: column);
  }
}

final selectedItemProvider =
    StateNotifierProvider<SelectedItemNotifier, SudokuCell>(
  (ref) => SelectedItemNotifier(),
);
