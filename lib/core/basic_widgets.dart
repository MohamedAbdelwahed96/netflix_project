import 'package:flutter/material.dart';

class CircleLoading extends StatelessWidget {
  const CircleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: Color.fromRGBO(243, 29, 28, 1), strokeWidth: 4));
  }
}
