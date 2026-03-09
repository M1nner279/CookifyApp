import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookify/core/l10n/s.dart';
import 'package:cookify/core/theme/t.dart';
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
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: T.secondary(context),
          border: Border.all(color: T.primary(context)),
        ),
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 35.0),

            Text(
              S.of(context).cookifyCachedNetworkImageError,
              style: T.bodyLarge(context).copyWith(color: T.primary(context)),
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
