import 'package:cookify/config/theme/t.dart';
import 'package:flutter/material.dart';

enum _ActiveItem { home, search, constructor, favorite, profile }

class CookifyNavigationBar extends StatefulWidget {
  const CookifyNavigationBar({super.key});

  static const double _paddingVertical = 12.0;
  static const double _itemHeight = 48.0;
  static const double barHeight = _paddingVertical * 2 + _itemHeight;

  @override
  State<CookifyNavigationBar> createState() => _CookifyNavigationBarState();
}

class _CookifyNavigationBarState extends State<CookifyNavigationBar> {
  var _activeItem = _ActiveItem.home;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(
        horizontal: 16.0,
        vertical: CookifyNavigationBar._paddingVertical,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0xFF120A08), Colors.transparent],
          stops: [0.8, 1.0],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _Item(
            onTap: () {
              setState(() => _activeItem = _ActiveItem.home);
            },
            isActive: _activeItem == _ActiveItem.home,
            iconData: _activeItem == _ActiveItem.home
                ? Icons.home
                : Icons.home_outlined,
          ),

          _Item(
            onTap: () {
              setState(() => _activeItem = _ActiveItem.search);
            },
            isActive: _activeItem == _ActiveItem.search,
            iconData: Icons.search,
            iconSize: _activeItem == _ActiveItem.search ? 20.0 : 18.0,
          ),

          _Item(
            onTap: () {
              setState(() => _activeItem = _ActiveItem.constructor);
            },
            isActive: _activeItem == _ActiveItem.constructor,
            iconData: _activeItem == _ActiveItem.constructor
                ? Icons.add_circle
                : Icons.add_circle_outline,
            iconSize: 26.0,
          ),

          _Item(
            onTap: () {
              setState(() => _activeItem = _ActiveItem.favorite);
            },
            isActive: _activeItem == _ActiveItem.favorite,
            iconData: _activeItem == _ActiveItem.favorite
                ? Icons.bookmark
                : Icons.bookmark_outline,
          ),

          _Item(
            onTap: () {
              setState(() => _activeItem = _ActiveItem.profile);
            },
            isActive: _activeItem == _ActiveItem.profile,
            iconData: _activeItem == _ActiveItem.profile
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
    this.iconSize = 18.0,
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
              ? T.of(context).colorScheme.secondary
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
              ? T.of(context).colorScheme.primary
              : const Color(0x88FFFFFF),
        ),
      ),
    );
  }
}
