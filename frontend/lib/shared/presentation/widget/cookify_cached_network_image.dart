import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookify/config/l10n/s.dart';
import 'package:cookify/config/theme/t.dart';
import 'package:flutter/material.dart';

class CookifyCachedNetworkImage extends StatelessWidget {
  const CookifyCachedNetworkImage(
    this.imageUrl, {
    super.key,
    this.width,
    this.height,
  });

  final String? imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      errorWidget: (context, url, error) => Container(
        padding: const .all(8.0),
        color: T.of(context).colorScheme.secondary,
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 35.0),

            Text(
              S.of(context).cookifyCachedNetworkImageError,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
