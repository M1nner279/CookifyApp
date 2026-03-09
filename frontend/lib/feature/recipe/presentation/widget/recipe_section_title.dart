import 'package:cookify/core/theme/t.dart';
import 'package:flutter/material.dart';

class RecipeSectionTitle extends StatelessWidget {
  const RecipeSectionTitle(this.data, {super.key});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(data, style: T.titleLarge(context));
  }
}
