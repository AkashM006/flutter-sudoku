import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/providers/provider_keys.dart';
import 'package:sudoku/providers/shared_preference_provider.dart';

class SudokuCell {
  SudokuCell({required this.row, required this.column});
  final int row, column;

  factory SudokuCell.fromJson(Map<String, dynamic> json) {
    return SudokuCell(
      row: json['row'] ?? 0,
      column: json['column'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "row": row,
      "column": column,
    };
  }
}

class SelectedItemNotifier extends StateNotifier<SudokuCell> {
  final SharedPreferences sp;
  SelectedItemNotifier(this.sp)
      : super(
          sp.getString(selectedItemProviderKey) != null
              ? SudokuCell.fromJson(
                  jsonDecode(
                    sp.getString(selectedItemProviderKey)!,
                  ),
                )
              : SudokuCell(
                  row: 0,
                  column: 0,
                ),
        );

  void setSelected(int row, int column) {
    final result = SudokuCell(row: row, column: column);
    state = result;
    sp.setString(selectedItemProviderKey, jsonEncode(result));
  }
}

final selectedItemProvider =
    StateNotifierProvider<SelectedItemNotifier, SudokuCell>(
  (ref) {
    final sharedPreference = ref.watch(sharedPreferenceProvider);
    return SelectedItemNotifier(sharedPreference);
  },
);
