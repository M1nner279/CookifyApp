import 'package:cookify/config/constant/app_constant.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        appName,
        style: TextStyle(
          color: const Color(0xFFF5E6D3),
          fontSize: 24.0,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.0,
          height: 32.0 / 24.0,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_none, size: 28.0, color: const Color(0xFFF5E6D3),),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
