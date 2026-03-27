import 'package:cookify/config/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.failureMessage,
    required this.isPassword,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final String? failureMessage;
  final bool isPassword;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.0,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Color(0x881A0F0A),
            fontSize: 10.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            height: 15.0 / 10.0,
          ),
        ),

        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: widget.failureMessage == null
                  ? null
                  : Border.all(color: AppPalette.error),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: TextField(
              controller: widget.controller,
              obscureText: widget.isPassword && !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(
                  color: Color(0x4C1A0F0A),
                  fontSize: 14.0,
                  letterSpacing: 0,
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Color(0x5C1A0F0A),
                        ),
                      )
                    : null,
                filled: true,
                fillColor: Color(0x1C1A0F0A),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
        ),

        if (widget.failureMessage != null)
          Row(
            spacing: 8.0,
            children: [
              Icon(Icons.error, color: AppPalette.error, size: 12.0),

              Text(
                widget.failureMessage!,
                style: TextStyle(
                  color: AppPalette.error,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0,
                  height: 16.5 / 11.0,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
