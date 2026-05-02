import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CookifyNavigationBar extends StatefulWidget {
  const CookifyNavigationBar({super.key, required this.index});

  final int index;

  @override
  State<CookifyNavigationBar> createState() => _CookifyNavigationBarState();
}

class _CookifyNavigationBarState extends State<CookifyNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final index = widget.index;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2C1C16),
        border: Border.all(color: const Color(0x1AE5C9A8)),
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _Item(
            onTap: () {
              context.go('/');
            },
            isActive: index == 0,
            activeIconData: Icons.home,
            inactiveIconData: Icons.home_outlined,
          ),

          _Item(
            onTap: () {
              context.go('/search-form');
            },
            isActive: index == 1,
            activeIconData: Icons.search,
            inactiveIconData: Icons.search,
          ),

          _Item(
            onTap: () {
              context.go('/create');
            },
            isActive: index == 2,
            activeIconData: Icons.add,
            inactiveIconData: Icons.add,
          ),

          _Item(
            onTap: () {
              context.go('/saved');
            },
            isActive: index == 3,
            activeIconData: Icons.bookmark,
            inactiveIconData: Icons.bookmark_border,
          ),

          _Item(
            onTap: () {
              context.go('/profile');
            },
            isActive: index == 4,
            activeIconData: Icons.person,
            inactiveIconData: Icons.person_outline,
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.onTap,
    required this.isActive,
    required this.activeIconData,
    required this.inactiveIconData,
  });

  final VoidCallback onTap;
  final bool isActive;
  final IconData activeIconData;
  final IconData inactiveIconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFE5C9A8) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
        ),
        width: 40.0,
        height: 40.0,
        child: Icon(
          isActive ? activeIconData : inactiveIconData,
          color: isActive ? Color(0xFF2C1C16) : const Color(0xFFE5C9A8),
          size: 24.0,
        ),
      ),
    );
  }
}
