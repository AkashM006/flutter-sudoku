import 'package:flutter/material.dart';
import 'package:sudoku/utils/sudoku_utils.dart';
import 'package:sudoku/widgets/home/button_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            const ButtonList(),
          ],
        ),
      ),
    );
  }
}
