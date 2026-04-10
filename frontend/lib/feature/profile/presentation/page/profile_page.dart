import 'package:cookify/feature/profile/presentation/bloc/profile_cubit.dart';
import 'package:cookify/feature/profile/presentation/page/profile_page_content.dart';
import 'package:cookify/feature/profile/presentation/widget/profile_app_bar.dart';
import 'package:cookify/service/di/di.dart';
import 'package:cookify/shared/presentation/widget/cookify_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: Column(
        children: [
          Expanded(
            child: BlocProvider<ProfileCubit>.value(
              value: DI.getIt(),
              child: const ProfilePageContent(),
            ),
          ),

          const Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: CookifyNavigationBar(currentIndex: ActiveItem.profile,),
          ),
        ],
      ),
      backgroundColor: Color(0xFF1A0F0A),
    );
  }
}
