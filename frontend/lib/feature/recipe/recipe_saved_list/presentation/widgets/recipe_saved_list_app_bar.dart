import 'package:flutter/material.dart';

class RecipeSavedListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const RecipeSavedListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Ваша кухня',
        style: TextStyle(color: Color(0xFFE5C9A8), fontWeight: FontWeight.w700),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
