import 'package:cookify/config/constant/app_constant.dart';
import 'package:cookify/config/theme/t.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        appName,
        style: TextStyle(
          color: T.of(context).colorScheme.secondary,
          fontSize: 24.0,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.0,
          height: 32.0 / 24.0,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_none, size: 28.0),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
