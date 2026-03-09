import 'package:cookify/common/presentation/widget/cookify_image.dart';
import 'package:cookify/core/theme/t.dart';
import 'package:flutter/material.dart';

class CookifyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CookifyAppBar({super.key, this.leading, this.action});

  final Widget? leading;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          leading: leading,
          automaticallyImplyLeading: false,
          title: CookifyImage('cookify_title', height: kToolbarHeight * 0.6),
          actions: [?action],
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
