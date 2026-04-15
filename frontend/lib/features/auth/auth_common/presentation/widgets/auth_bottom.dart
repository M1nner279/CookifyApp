import 'package:flutter/material.dart';

class AuthBottom extends StatelessWidget {
  const AuthBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 32.0,
      children: [
        _Line(),

        Icon(Icons.restaurant, size: 16.0, color: Color(0xFFE5C9A8)),

        _Line(),
      ],
    );
  }
}

class _Line extends StatelessWidget {
  const _Line();

  @override
  Widget build(BuildContext context) {
    return Container(color: Color(0xFFE5C9A8), width: 48.0, height: 1.0);
  }
}
