import 'package:cookify/feature/profile/domain/entity/locale_entity.dart';
import 'package:cookify/feature/profile/domain/entity/user_info_entity.dart';
import 'package:cookify/feature/profile/presentation/widget/profile_button.dart';
import 'package:cookify/feature/profile/presentation/widget/profile_user_card.dart';
import 'package:cookify/feature/profile/presentation/widget/profile_user_recipe_statistic_card.dart';
import 'package:flutter/material.dart';

class ProfileLoadedContent extends StatelessWidget {
  const ProfileLoadedContent({
    super.key,
    required this.userInfo,
    required this.locale,
  });

  final UserInfoEntity userInfo;
  final LocaleEntity locale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ProfileUserCard(
              user: userInfo.user,
              languageCode: locale.languageCode.languageCode,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32.0)),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.0,
              children: [
                Text(
                  'Достижения',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 8.0,
                  children: [
                    Expanded(
                      child: ProfileUserRecipeStatisticCard(
                        iconData: Icons.bookmark,
                        count: userInfo.userRecipeStatistic.favoriteRecipeCount,
                        title: 'Сохраненных',
                      ),
                    ),

                    Expanded(
                      child: ProfileUserRecipeStatisticCard(
                        iconData: Icons.room_service_sharp,
                        count: userInfo.userRecipeStatistic.createdRecipeCount,
                        title: 'Созданных',
                      ),
                    ),

                    Expanded(
                      child: ProfileUserRecipeStatisticCard(
                        iconData: Icons.star,
                        count:
                            userInfo.userRecipeStatistic.publishedRecipeCount,
                        title: 'Опубликованных',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32.0)),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.0,
              children: [
                Text(
                  'Настройки',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),

                ProfileButton(
                  onTap: () {},
                  iconData: Icons.language,
                  title: 'Русский',
                ),

                ProfileButton(
                  onTap: () {},
                  iconData: Icons.logout,
                  title: 'Выйти',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
