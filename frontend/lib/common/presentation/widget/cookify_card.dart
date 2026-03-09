import 'package:cookify/core/theme/t.dart';
import 'package:flutter/material.dart';

class CookifyCard extends StatelessWidget {
  const CookifyCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        gradient: T.primaryGradient(context),
      ),
      child: child,
    );
  }
}
