import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CookifyHero extends StatefulWidget {
  const CookifyHero({super.key, required this.tag, required this.child});

  final String tag;
  final Widget child;

  @override
  State<CookifyHero> createState() => _CookifyHeroState();
}

class _CookifyHeroState extends State<CookifyHero> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.tag),
      onVisibilityChanged: (info) {
        if (mounted) {
          setState(() => _visible = info.visibleFraction > 0.3);
        }
      },
      child: _visible
          ? Hero(tag: widget.tag, child: widget.child)
          : widget.child,
    );
  }
}
