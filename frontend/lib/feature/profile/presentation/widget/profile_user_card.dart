import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookify/config/theme/t.dart';
import 'package:cookify/feature/profile/domain/entity/user_entity.dart';
import 'package:cookify/shared/presentation/widget/cookify_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({
    super.key,
    required this.user,
    required this.languageCode,
  });

  final UserEntity user;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    return CookifyCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          spacing: 16.0,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: T.of(context).colorScheme.primary,
                        width: 4.0,
                      ),
                      shape: BoxShape.circle,
                    ),
                    width: 96.0,
                    height: 96.0,
                    child: CachedNetworkImage(
                      imageUrl: user.avatarUrl ?? '',
                      errorWidget: (context, url, error) => Center(
                        child: Text(
                          user.login[0].toUpperCase(),
                          style: T
                              .of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: T.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    width: 30.0,
                    height: 30.0,
                    child: Icon(
                      Icons.camera_alt,
                      color: T.of(context).colorScheme.secondary,
                      size: 16.0,
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.login,
                    style: T
                        .of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
              
                  Text(
                    user.email,
                    style: T
                        .of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
              
                  Text(
                    'Участвует с ${DateFormat('d MMMM yyyy', languageCode).format(user.createdAt)}',
                    style: T
                        .of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
