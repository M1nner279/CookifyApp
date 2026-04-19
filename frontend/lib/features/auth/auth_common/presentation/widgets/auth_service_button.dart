import 'package:cookify/core/presentation/widgets/cookify_image.dart';
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
        height: 50.0,
        decoration: BoxDecoration(
          color: const Color(0x1AE5C9A8),
          border: Border.all(color: const Color(0x0DE5C9A8)),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: CookifyImage(imagePath),
      ),
    );
  }
}
