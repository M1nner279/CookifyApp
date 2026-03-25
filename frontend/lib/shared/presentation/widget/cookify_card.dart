import 'package:cookify/config/theme/t.dart';
import 'package:flutter/material.dart';

class CookifyCard extends StatelessWidget {
  const CookifyCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: T.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
  }
}
