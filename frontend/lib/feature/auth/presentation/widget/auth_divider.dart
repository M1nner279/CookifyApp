import 'package:flutter/material.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16.0,
      children: [
        Expanded(child: const _Line()),

        Text(
          'или через',
          style: TextStyle(
            color: Color(0x481A0F0A),
            fontSize: 10.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            height: 15.0 / 10.0,
          ),
        ),

        Expanded(child: const _Line()),
      ],
    );
  }
}

class _Line extends StatelessWidget {
  const _Line();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x481A0F0A),
      width: double.infinity,
      height: 1.0,
    );
  }
}
