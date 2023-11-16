import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/models/sudoku.dart';

void encodeAndPersist(SharedPreferences sp, String key, dynamic value) {
  sp.setString(key, jsonEncode(value));
}

const numbers = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
];

List<List<int>> getNumbersMappedToIndices(List<List<int>>? table) {
  if (table == null) return [[]];
  List<int> expandedTable = table.expand((element) => element).toList();

  final result = numbers.map(
    (number) {
      return expandedTable
          .asMap()
          .entries
          .where((item) => item.value == number)
          .map((e) => e.key)
          .toList();
    },
  ).toList();

  return result;
}

List<List<int>> castToListOfList(List<dynamic> list) {
  return list.map((e) => (e as List).cast<int>()).toList();
}

List<History> castToListOfHistory(List<dynamic> list) {
  return list.map((e) {
    final json = e as Map<String, dynamic>;

    return History.fromJson(json);
  }).toList();
}
