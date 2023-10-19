import 'dart:async';
import 'package:flutter/material.dart';

class SudokuTimer extends StatefulWidget {
  const SudokuTimer({super.key});

  @override
  State<SudokuTimer> createState() {
    return _SudokuTimer();
  }
}

class _SudokuTimer extends State<SudokuTimer> {
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime += const Duration(seconds: 1);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_elapsedTime.inMinutes.toString().padLeft(2, '0')}:${(_elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}',
    );
  }
}
