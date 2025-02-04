import 'package:flutter/material.dart';
import 'package:netfelix_project/core/colors.dart';

class DefaultImageWidget extends StatelessWidget {
  final String text;
  final size;
  const DefaultImageWidget({super.key, required this.text, this.size=null});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      decoration: BoxDecoration(
          border: Border.all(color: ColorsManager.mainRed)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Center(
            child: Text(text,
          style: TextStyle(
              color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700),
        )),
      ),
    );
  }
}
