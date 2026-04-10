import 'package:cookify/config/theme/t.dart';
import 'package:cookify/shared/presentation/widget/cookify_card.dart';
import 'package:flutter/material.dart';

class ProfileUserRecipeStatisticCard extends StatelessWidget {
  const ProfileUserRecipeStatisticCard({
    super.key,
    required this.iconData,
    required this.count,
    required this.title,
  });

  final IconData iconData;
  final int count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CookifyCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 0.0,
          children: [
            Icon(iconData, color: const Color(0xFFF5E6D3)),

            Text(
              '$count',
              style: T
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w900, color: const Color(0xFFF5E6D3)),
            ),

            Text(
              title,
              style: T.of(context).textTheme.labelSmall!.copyWith(color: const Color(0xFFF5E6D3)),
              overflow: TextOverflow.ellipsis,
              
            ),
          ],
        ),
      ),
    );
  }
}
