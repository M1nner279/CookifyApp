import 'package:cookify/shared/presentation/widget/cookify_image.dart';
import 'package:flutter/widgets.dart';

class AuthServiceButton extends StatelessWidget {
  const AuthServiceButton({
    super.key,
    required this.onPressed,
    required this.imagePath,
  });

  final VoidCallback onPressed;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 48.0,
        decoration: BoxDecoration(
          color: const Color(0x19E5C9A8),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: CookifyImage(imagePath),
      ),
    );
  }
}
