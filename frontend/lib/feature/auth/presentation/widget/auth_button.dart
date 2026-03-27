import 'package:cookify/config/theme/t.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    this.onPressed,
    required this.title,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: T.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(16.0),
        ),
        width: double.infinity,
        height: 64.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12.0,
          children: [
            if (isLoading)
              SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  color: T.of(context).colorScheme.secondary,
                ),
              ),

            Text(
              title,
              style: TextStyle(
                color: T.of(context).colorScheme.secondary,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
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
