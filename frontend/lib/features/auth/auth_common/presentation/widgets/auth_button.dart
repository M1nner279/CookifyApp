import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLoading = false,
  });

  final VoidCallback onPressed;
  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFE5C9A8),
          borderRadius: BorderRadius.circular(16.0),
        ),
        width: double.infinity,
        height: 64.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12.0,
          children: [
            if (isLoading)
              const SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(color: Color(0xFF1A0F0A)),
              ),

            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF1A0F0A),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.4,
                height: 24.0 / 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
