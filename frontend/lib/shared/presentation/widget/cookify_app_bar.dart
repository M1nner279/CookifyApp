import 'package:cookify/shared/presentation/widget/cookify_image.dart';
import 'package:cookify/config/theme/t.dart';
import 'package:flutter/material.dart';

class CookifyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CookifyAppBar({super.key, this.leading, this.actions});

  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          leading: leading,
          automaticallyImplyLeading: false,
          title: CookifyImage('cookify_title', height: kToolbarHeight * 0.6),
          actions: actions,
          automaticallyImplyActions: false,
          centerTitle: true,
        ),

        Container(color: T.primary(context), height: 1.0),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 1);
}
