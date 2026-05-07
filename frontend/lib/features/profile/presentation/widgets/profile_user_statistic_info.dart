import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/features/profile/domain/entities/user_statistic_entity.dart';
import 'package:flutter/material.dart';

class ProfileUserStatisticInfo extends StatelessWidget {
  const ProfileUserStatisticInfo({super.key, required this.userStatistic});

  final UserStatisticEntity? userStatistic;

  @override
  Widget build(BuildContext context) {
    final isLoading = userStatistic == null;

    return Row(
      spacing: 12.0,
      children: [
        Expanded(
          child: isLoading
              ? const _LoadingStatistic()
              : _Statistic(
                  value: userStatistic!.favoriteRecipesCount,
                  label: MyLocale.of(context).profileUserStatisticInfoFavorite,
                ),
        ),

        Expanded(
          child: isLoading
              ? const _LoadingStatistic()
              : _Statistic(
                  value: userStatistic!.createdRecipesCount,
                  label: MyLocale.of(context).profileUserStatisticInfoCreated,
                ),
        ),

        Expanded(
          child: isLoading
              ? const _LoadingStatistic()
              : _Statistic(
                  value: userStatistic!.publishedRecipesCount,
                  label: MyLocale.of(context).profileUserStatisticInfoPublished,
                ),
        ),
      ],
    );
  }
}

class _Statistic extends StatelessWidget {
  const _Statistic({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2C1C16),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        spacing: 4.0,
        children: [
          Text(
            value > 999
                ? '${(value / 1000).toStringAsFixed(2)}k'
                : value.toString(),
            style: TextStyle(
              color: Color(0xFFE5C9A8),
              fontSize: 24.0,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.0,
              height: 24.0 / 24.0,
            ),
          ),

          Text(
            label,
            style: TextStyle(
              color: Color(0xFFE5C9A8),
              fontSize: 9.0,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.9,
              height: 13.5 / 9.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingStatistic extends StatelessWidget {
  const _LoadingStatistic();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 66.0,
      decoration: BoxDecoration(
        color: const Color(0xFF2C1C16),
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }
}
