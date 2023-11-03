import 'package:flutter/material.dart';
import 'package:sudoku/utils/sudoku_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _newGameHandler() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sudoku"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Classic Sudoku",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: selectedTextColor,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _newGameHandler,
              child: const Text('New Game'),
            ),
          ],
        ),
      ),
    );
  }
}
