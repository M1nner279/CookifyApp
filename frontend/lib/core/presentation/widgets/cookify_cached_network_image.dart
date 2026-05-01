import 'package:cached_network_image/cached_network_image.dart';
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
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: const Color(0xFF2C1C16),
      ),
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      errorWidget: (context, url, error) => Center(
        child: Icon(
          Icons.photo_size_select_actual,
          size: 35.0,
          color: const Color(0x1AE5C9A8),
        ),
      ),
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
