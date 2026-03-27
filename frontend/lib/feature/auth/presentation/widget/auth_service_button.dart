import 'package:cookify/shared/presentation/widget/cookify_image.dart';
import 'package:flutter/widgets.dart';

class AuthServiceButton extends StatelessWidget {
  const AuthServiceButton({
    super.key,
    required this.onTap,
    required this.imagePath,
  });

  final VoidCallback onTap;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 48.0,
      decoration: BoxDecoration(
        color: Color(0x1C1A0F0A),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: CookifyImage(imagePath),
    ));
  }
}
