import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CookifyTextField extends StatefulWidget {
  const CookifyTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.onChanged,
    this.inputFormatter,
    this.inputType,
    this.maxLength,
    this.label,
    required this.hint,
    this.isPassword = false,
    this.failureMessage,
    this.maxLines,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final TextInputFormatter? inputFormatter;
  final TextInputType? inputType;
  final int? maxLength;
  final String? label;
  final String hint;
  final bool isPassword;
  final String? failureMessage;
  final int? maxLines;

  @override
  State<CookifyTextField> createState() => _CookifyTextFieldState();
}

class _CookifyTextFieldState extends State<CookifyTextField> {
  late bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.0,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: const TextStyle(
              color: Color(0x80FFE6C9),
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              height: 15.0 / 10.0,
            ),
          ),

        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.failureMessage == null
                    ? const Color(0x0DE5C9A8)
                    : const Color(0xFF83260E),
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              obscureText: widget.isPassword && !_isPasswordVisible,
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(
                  color: Color(0x4DE5C9A8),
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0,
                ),
                counterText: '',
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
                          color: const Color(0x66E5C9A8),
                        ),
                      )
                    : null,
                filled: true,
                fillColor: const Color(0x1AE5C9A8),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
              keyboardType: widget.inputType,
              maxLength: widget.maxLength,
              onChanged: widget.onChanged,
              inputFormatters: [?widget.inputFormatter],
              style: const TextStyle(color: Color(0xFFFFE6C9)),
              cursorColor: Color(0xFFFFE6C9),
            ),
          ),
        ),

        if (widget.failureMessage != null)
          Row(
            spacing: 8.35,
            children: [
              const Icon(Icons.error, color: Color(0xFF83260E), size: 11.67),

              Expanded(
                child: Text(
                  widget.failureMessage!,
                  style: const TextStyle(
                    color: Color(0xFF83260E),
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.0,
                    height: 16.5 / 11.0,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
