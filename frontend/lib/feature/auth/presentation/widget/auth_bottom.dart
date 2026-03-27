import 'package:cookify/config/theme/t.dart';
import 'package:flutter/material.dart';

class AuthBottom extends StatelessWidget {
  const AuthBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 32.0,
      children: [
        const _Line(),

        Icon(
          Icons.restaurant,
          size: 16.0,
          color: T.of(context).colorScheme.secondary,
        ),

        const _Line(),
      ],
    );
  }
}

class _Line extends StatelessWidget {
  const _Line();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: T.of(context).colorScheme.secondary,
      width: 48.0,
      height: 1.0,
    );
  }
}
