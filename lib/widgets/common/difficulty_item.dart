import 'package:flutter/material.dart';
import 'package:sudoku/utils/sudoku_utils.dart';

class DifficultyItem extends StatelessWidget {
  const DifficultyItem({
    super.key,
    required this.difficulty,
    required this.clickHandler,
  });
  final String difficulty;
  final Function() clickHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: const BoxDecoration(
        color: customBackgroundColor,
        borderRadius: BorderRadius.all(radius),
      ),
      child: InkWell(
        onTap: clickHandler,
        borderRadius: const BorderRadius.all(radius),
        splashColor: neighboringColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                difficulty,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: customTextColor,
                    ),
              ),
              const Icon(
                Icons.arrow_right,
                color: selectedTextColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
