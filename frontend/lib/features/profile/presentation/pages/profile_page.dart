import 'package:cookify/di/di.dart';
import 'package:cookify/features/profile/di/profile_di.dart';
import 'package:cookify/features/profile/navigator/profile_navigator.dart';
import 'package:cookify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:cookify/features/profile/presentation/bloc/profile_event.dart';
import 'package:cookify/features/profile/presentation/pages/profile_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.navigator});

  final ProfileNavigator navigator;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ProfileBloc(
        profileNavigator: navigator,
        profileDependency: Di.profileDependency,
        getUserUseCase: ProfileDi.getUserUseCase,
        updateAvatarUseCase: ProfileDi.updateAvatarUseCase,
      )..add(InitProfile()),
      child: const ProfilePageContent(),
    );
  }
}
