import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/screens/home.dart';

// todo:
// 1. Handle the case where user finishes the sudoku correctly (Done)
// 2. Persist state
// 3. Continue button in the buttons list

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      // home: const SudokuScreen(),
      home: const HomeScreen(),
    );
  }
}
