import 'package:flutter/material.dart';
import 'package:sudoku/widgets/sudoku_table.dart';
import 'package:sudoku/widgets/sudoku_timer.dart';

class SudokoScreen extends StatelessWidget {
  const SudokoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku - Hard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: const SudokuTimer(),
              ),
              const SudokuTable(),
            ],
          ),
        ),
      ),
    );
  }
}
