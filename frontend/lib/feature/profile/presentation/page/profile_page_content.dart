import 'package:cookify/feature/profile/presentation/bloc/profile_cubit.dart';
import 'package:cookify/feature/profile/presentation/bloc/profile_state.dart';
import 'package:cookify/feature/profile/presentation/widget/profile_loaded_content.dart';
import 'package:cookify/shared/presentation/widget/cookify_error_content.dart';
import 'package:cookify/shared/presentation/widget/cookify_loading_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePageContent extends StatelessWidget {
  const ProfilePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        switch (state) {
          case ProfileInitial():
            SchedulerBinding.instance.addPostFrameCallback((_) {
              context.read<ProfileCubit>().init();
            });
            return const CookifyLoadingContent();

          case ProfileLoading():
            return const CookifyLoadingContent();

          case ProfileLoaded():
            return ProfileLoadedContent(
              userInfo: state.userInfo,
              locale: state.locale,
            );

          case ProfileError():
            return CookifyErrorContent();

          default:
            throw UnimplementedError();
        }
      },
    );
  }
}
