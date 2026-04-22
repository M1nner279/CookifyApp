import 'package:flutter/material.dart';

class RecipeSearchSectionCard extends StatelessWidget {
  const RecipeSearchSectionCard({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2C1C16),
        border: Border.all(color: const Color(0x1AE5C9A8)),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFE5C9A8),
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              height: 28.0 / 20.0,
            ),
          ),

          child,
        ],
      ),
    );
  }
}
