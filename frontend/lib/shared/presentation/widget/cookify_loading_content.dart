import 'dart:math';

import 'package:cookify/shared/presentation/widget/cookify_image.dart';
import 'package:flutter/material.dart';

class CookifyLoadingContent extends StatefulWidget {
  const CookifyLoadingContent({super.key});

  @override
  State<CookifyLoadingContent> createState() => _CookifyLoadingContentState();
}

class _CookifyLoadingContentState extends State<CookifyLoadingContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return ClipPath(
            clipper: SweepClipper(progress: _controller.value),
            child: child,
          );
        },
        child: const CookifyImage('cookify_logo', width: 75.0, height: 75.0),
      ),
    );
  }
}

class SweepClipper extends CustomClipper<Path> {
  SweepClipper({required this.progress});

  final double progress;

  @override
  Path getClip(Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width;

    final double cycle = progress * 2;

    double startFraction;
    double endFraction;

    if (cycle <= 1) {
      startFraction = 0;
      endFraction = cycle;
    } else {
      startFraction = cycle - 1;
      endFraction = 1;
    }

    final startAngle = -pi / 2 - 2 * pi * startFraction;
    final sweepAngle = -2 * pi * (endFraction - startFraction);

    return Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
      )
      ..close();
  }

  @override
  bool shouldReclip(SweepClipper oldClipper) => oldClipper.progress != progress;
}
