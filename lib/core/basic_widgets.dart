import 'package:flutter/material.dart';
import 'colors.dart';

class CircleLoading extends StatelessWidget {
  const CircleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(child: CircularProgressIndicator(
          color: ColorsManager.mainRed, strokeWidth: 4)),
    );
  }
}