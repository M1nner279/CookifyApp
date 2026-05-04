import 'dart:io';

import 'package:cookify/core/presentation/widgets/cookify_cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cookifyNetworkOrFileImage(
  String url, {
  double? width,
  double? height,
}) {
  final u = url.trim();
  if (u.isEmpty) {
    return _placeholder(width, height);
  }
  final isNetwork =
      u.startsWith('http://') || u.startsWith('https://');
  if (isNetwork) {
    return CookifyCachedNetworkImage(u, width: width, height: height);
  }
  return Image.file(
    File(u),
    width: width,
    height: height,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) => _placeholder(width, height),
  );
}

Widget _placeholder(double? width, double? height) {
  return Container(
    width: width,
    height: height,
    color: const Color(0xFF2C1C16),
    child: const Center(
      child: Icon(
        Icons.photo_size_select_actual,
        size: 35.0,
        color: Color(0x1AE5C9A8),
      ),
    ),
  );
}
