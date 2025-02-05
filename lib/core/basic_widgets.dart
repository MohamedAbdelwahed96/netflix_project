import 'package:flutter/material.dart';
import 'colors.dart';

class CircleLoading extends StatelessWidget {
  const CircleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: ColorsManager.mainRed, strokeWidth: 4));
  }
}