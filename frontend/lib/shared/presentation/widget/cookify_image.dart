import 'package:flutter/material.dart';

class CookifyImage extends StatelessWidget {
  const CookifyImage(this.asset, {super.key, this.width, this.height});

  final String asset;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$asset.png',
      width: width,
      height: height,
    );
  }
}
