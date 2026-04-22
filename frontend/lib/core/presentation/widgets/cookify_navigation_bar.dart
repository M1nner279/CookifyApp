import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CookifyNavigationBar extends StatefulWidget {
  const CookifyNavigationBar({super.key});

  @override
  State<CookifyNavigationBar> createState() => _CookifyNavigationBarState();
}

class _CookifyNavigationBarState extends State<CookifyNavigationBar> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
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
              setState(() {
                _index = 0;
              });
              context.go('/');
            },
            isActive: _index == 0,
            activeIconData: Icons.home,
            inactiveIconData: Icons.home_outlined,
          ),

          _Item(
            onTap: () {
              setState(() {
                _index = 1;
              });
              context.go('/search-form');
            },
            isActive: _index == 1,
            activeIconData: Icons.search,
            inactiveIconData: Icons.search,
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
