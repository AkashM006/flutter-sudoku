import 'package:flutter/material.dart';

class AnimatedRiveButton extends StatelessWidget {
  const AnimatedRiveButton({
    super.key,
    required this.onTap,
    required this.animatedChild,
    required this.title,
  });

  final void Function() onTap;
  final Widget animatedChild;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: animatedChild,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(title),
        ],
      ),
    );
  }
}
