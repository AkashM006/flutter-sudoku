import 'package:flutter/material.dart';

// todo: once game over show time, and also pause the timer.

class GameOverDialog extends StatelessWidget {
  const GameOverDialog({super.key});

  void _restartGame() {}

  void _newGame() {}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Game over',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        "Whoops! The game is over because you have made 3 mistakes.",
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(onPressed: _restartGame, child: const Text("Restart")),
        TextButton(onPressed: _newGame, child: const Text("New Game")),
      ],
    );
  }
}
