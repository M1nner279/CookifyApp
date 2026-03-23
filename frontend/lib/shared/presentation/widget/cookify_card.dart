import 'package:flutter/material.dart';

class CookifyCard extends StatelessWidget {
  const CookifyCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF5E6D3),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
  }
}
