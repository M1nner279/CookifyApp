import 'package:cookify/features/profile/domain/entities/user_entity.dart';
import 'package:cookify/features/profile/domain/entities/user_statistic_entity.dart';
import 'package:cookify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:cookify/features/profile/presentation/bloc/profile_state.dart';
import 'package:cookify/features/profile/presentation/widgets/profile_settings.dart';
import 'package:cookify/features/profile/presentation/widgets/profile_title.dart';
import 'package:cookify/features/profile/presentation/widgets/profile_user_info.dart';
import 'package:cookify/features/profile/presentation/widgets/profile_user_statistic_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePageContent extends StatelessWidget {
  const ProfilePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: ProfileTitle()),

        const SliverToBoxAdapter(child: SizedBox(height: 16.0)),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: BlocSelector<ProfileBloc, ProfileState, UserEntity?>(
                  selector: (state) =>
                      state is ProfileLoaded ? state.user : null,
                  builder: (context, user) {
                    return ProfileUserInfo(user: user);
                  },
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32.0)),

              SliverToBoxAdapter(
                child:
                    BlocSelector<
                      ProfileBloc,
                      ProfileState,
                      UserStatisticEntity?
                    >(
                      selector: (state) =>
                          state is ProfileLoaded ? state.user.statistic : null,
                      builder: (context, userStatistic) {
                        return ProfileUserStatisticInfo(
                          userStatistic: userStatistic,
                        );
                      },
                    ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32.0)),

              SliverToBoxAdapter(
                child: BlocSelector<ProfileBloc, ProfileState, Locale>(
                  selector: (state) => state.locale,
                  builder: (context, locale) {
                    return ProfileSettings(locale: locale);
                  },
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            ],
          ),
        ),
      ],
    );
  }
}
