import 'package:flutter/material.dart';
import 'package:sudoku/providers/selected_item_provider.dart';
import 'package:sudoku/providers/sudoku_game_provider.dart';

const radius = Radius.circular(15);

const Map<String, BorderRadius?> itemBorderMapping = {
  '00': BorderRadius.only(topLeft: radius),
  '08': BorderRadius.only(topRight: radius),
  '80': BorderRadius.only(bottomLeft: radius),
  '88': BorderRadius.only(bottomRight: radius),
};

const neighboringColor = Color(0xFFD4E2FF);
const selectedColor = Color(0xFFABC5FE);
const oddCellGroupColor = Color.fromARGB(255, 225, 225, 225);
const selectedTextColor = Color(0xFF0d31f9);
const wrongTextColor = Colors.red;

const strongBorder = BorderSide(
  color: Colors.black,
  width: 2,
);
const lightBorder = BorderSide(
  color: Color.fromARGB(175, 150, 150, 150),
  width: 1,
);
const invisibleBorder = BorderSide.none;

class Level {
  const Level({required this.title, required this.difficulty});

  final String title;
  final Difficulty difficulty;
}

class SudokuUtils {
  static bool _isCornerItem(int row, int column) {
    return (row == 0 || row == 8) && (column == 0 || column == 8);
  }

  static int _getCellGroupNumber(int row, int column) {
    if (row >= 0 && row <= 2) {
      if (column >= 0 && column <= 2) return 0;
      if (column >= 3 && column <= 5) return 1;
      return 2;
    }

    if (row >= 3 && row <= 5) {
      if (column >= 0 && column <= 2) return 3;
      if (column >= 3 && column <= 5) return 4;
      return 5;
    }

    if (column >= 0 && column <= 2) return 6;
    if (column >= 3 && column <= 5) return 7;
    return 8;
  }

  static BorderRadius? getBorderRadius(int row, int column) {
    final isInCorner = _isCornerItem(row, column);

    if (!isInCorner) return null;

    return itemBorderMapping['$row$column'];
  }

  static BorderSide _getTopBorder(int row, int column) {
    if (row == 0 || row == 8) return invisibleBorder;
    return (row == 3 || row == 6) ? strongBorder : lightBorder;
  }

  static BorderSide _getLeftBorder(int row, int column) {
    if (column == 0 || column == 8) return invisibleBorder;
    return (column == 3 || column == 6) ? strongBorder : lightBorder;
  }

  static BorderSide _getBottomBorder(int row, int column) {
    return (row == 7) ? lightBorder : invisibleBorder;
  }

  static BorderSide _getRightBorder(int row, int column) {
    return (column == 7) ? lightBorder : invisibleBorder;
  }

  static BoxBorder? getBorder(int row, int column) {
    if (_isCornerItem(row, column)) return null;
    return Border(
      top: _getTopBorder(row, column),
      left: _getLeftBorder(row, column),
      bottom: _getBottomBorder(row, column),
      right: _getRightBorder(row, column),
    );
  }

  static Color? getCellBackground(
      int row, int column, SudokuCell selected, bool isSameNumber) {
    final int selectedCellGroupNumber =
        _getCellGroupNumber(selected.row, selected.column);
    final int currentCellGroupNumber = _getCellGroupNumber(row, column);

    if ((selected.column == column && selected.row == row) || isSameNumber) {
      return selectedColor;
    }

    if (selectedCellGroupNumber == currentCellGroupNumber) {
      return neighboringColor;
    }

    if (selected.column == column || selected.row == row) {
      return neighboringColor;
    }
    if (currentCellGroupNumber % 2 == 0) {
      return oddCellGroupColor;
    }

    return null;
  }

  static Color? getCellTextColor(
    int row,
    int column,
    SudokuCell selected,
    bool isCorrect,
    bool shouldUserFill,
  ) {
    if (!isCorrect) {
      return wrongTextColor;
    }

    if (shouldUserFill || (selected.row == row && selected.column == column)) {
      return selectedTextColor;
    }

    return null;
  }
}
