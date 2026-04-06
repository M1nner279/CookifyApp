import 'package:cookify/config/theme/t.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum ActiveItem { home, search, constructor, favorite, profile }

class CookifyNavigationBar extends StatefulWidget {
  const CookifyNavigationBar({super.key, required this.currentIndex});

  static const double _paddingVertical = 12.0;
  static const double _itemHeight = 48.0;
  static const double barHeight = _paddingVertical * 2 + _itemHeight;

  final ActiveItem currentIndex;

  @override
  State<CookifyNavigationBar> createState() => _CookifyNavigationBarState();
}

class _CookifyNavigationBarState extends State<CookifyNavigationBar> {
  late var _activeItem = widget.currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(
        horizontal: 16.0,
        vertical: CookifyNavigationBar._paddingVertical,
      ),
      decoration: const BoxDecoration(
        color: Color(0xCD2C1C16),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _Item(
            onTap: () {
              setState(() => _activeItem = ActiveItem.home);
              context.go('/');
            },
            isActive: _activeItem == ActiveItem.home,
            iconData: _activeItem == ActiveItem.home
                ? Icons.home
                : Icons.home_outlined,
          ),

          _Item(
            onTap: () {
              setState(() => _activeItem = ActiveItem.search);
            },
            isActive: _activeItem == ActiveItem.search,
            iconData: Icons.search,
            iconSize: _activeItem == ActiveItem.search ? 20.0 : 18.0,
          ),

          _Item(
            onTap: () {
              setState(() => _activeItem = ActiveItem.constructor);
            },
            isActive: _activeItem == ActiveItem.constructor,
            iconData: _activeItem == ActiveItem.constructor
                ? Icons.add_circle
                : Icons.add_circle_outline,
            iconSize: 26.0,
          ),

          _Item(
            onTap: () {
              setState(() => _activeItem = ActiveItem.favorite);
              context.go('/saved');
            },
            isActive: _activeItem == ActiveItem.favorite,
            iconData: _activeItem == ActiveItem.favorite
                ? Icons.bookmark
                : Icons.bookmark_outline,
          ),

          _Item(
            onTap: () {
              setState(() => _activeItem = ActiveItem.profile);
              context.go('/profile');
            },
            isActive: _activeItem == ActiveItem.profile,
            iconData: _activeItem == ActiveItem.profile
                ? Icons.person
                : Icons.person_outline,
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
    required this.iconData,
    this.iconSize = 26.0,
  });

  final VoidCallback onTap;
  final bool isActive;
  final IconData iconData;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive
              ? Color(0xFFE5C9A8)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
        ),
        width: 48.0,
        height: CookifyNavigationBar._itemHeight,
        duration: const Duration(milliseconds: 200),
        child: Icon(
          iconData,
          size: iconSize,
          color: isActive
              ? Color(0xFF3E2D16)
              : const Color(0xFFFADCD2),
        ),
      ),
    );
  }
}
