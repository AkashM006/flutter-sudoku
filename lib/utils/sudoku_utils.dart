import 'package:flutter/material.dart';

const radius = Radius.circular(15);

const Map<String, BorderRadius?> itemBorderMapping = {
  '00': BorderRadius.only(topLeft: radius),
  '08': BorderRadius.only(topRight: radius),
  '80': BorderRadius.only(bottomLeft: radius),
  '88': BorderRadius.only(bottomRight: radius),
};

const strongBorder = BorderSide(
  color: Colors.black,
  width: 2,
);
const lightBorder = BorderSide(
  color: Color.fromARGB(255, 206, 206, 206),
  width: 1,
);
const invisibleBorder = BorderSide.none;

class SudokuUtils {
  static bool _isCornerItem(int row, int column) {
    return (row == 0 || row == 8) && (column == 0 || column == 8);
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
}
