import 'package:cookify/config/theme/t.dart';
import 'package:cookify/shared/presentation/widget/cookify_card.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.onTap,
    required this.iconData,
    required this.title,
  });

  final VoidCallback onTap;
  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CookifyCard(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            spacing: 16.0,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: T.of(context).colorScheme.primary.withAlpha(19),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Icon(iconData,color: const Color(0xFFF5E6D3)),
              ),

              Text(
                title,
                style: T
                    .of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w700, color: const Color(0xFFF5E6D3)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
