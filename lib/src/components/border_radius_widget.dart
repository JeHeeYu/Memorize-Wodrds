import 'package:flutter/material.dart';

class BorderRadiusStack extends StatelessWidget {
  final String imageAsset;
  final String text;
  final double? textSize;

  const BorderRadiusStack({required this.imageAsset, required this.text, this.textSize});

  @override
  Widget build(BuildContext context) {
    const double defaultTextSize = 18;

    final TextStyle textStyle = TextStyle(
      fontSize: textSize ?? defaultTextSize,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    return Stack(
      children: [
        Image(
          image: AssetImage(imageAsset),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      ],
    );
  }
}