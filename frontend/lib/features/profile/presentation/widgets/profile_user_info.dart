import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/features/profile/domain/entities/user_entity.dart';
import 'package:cookify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:cookify/features/profile/presentation/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfileUserInfo extends StatelessWidget {
  const ProfileUserInfo({super.key, required this.user});

  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    final isLoading = user == null;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Color(0xFF2C1C16),
        borderRadius: BorderRadius.circular(12.0),
      ),
      width: double.infinity,
      child: Column(
        spacing: 16.0,
        children: [
          isLoading
              ? const _LoadingAvatar()
              : _Avatar(avatarUrl: user!.avatarUrl, login: user!.login),

          isLoading
              ? const _LoadingInfo()
              : _Info(
                  login: user!.login,
                  email: user!.email,
                  createdAt: user!.createdAt,
                ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.avatarUrl, required this.login});

  final String? avatarUrl;
  final String login;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );

        if (context.mounted && image != null) {
          context.read<ProfileBloc>().add(
            UpdateAvatar(avatarFile: File(image.path)),
          );
        }
      },
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            width: 96.0,
            height: 96.0,
            decoration: BoxDecoration(
              color: Color(0xFFE5C9A8),
              border: Border.all(color: Color(0xFF1E100A), width: 4.0),
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage(
              imageUrl: avatarUrl ?? '',
              placeholder: (context, url) => _AvatarPlaceholder(login: login),
              errorWidget: (context, url, error) =>
                  _AvatarPlaceholder(login: login),
            ),
          ),

          Positioned(
            right: 0.0,
            bottom: 0.0,
            child: Container(
              alignment: Alignment.center,
              width: 28.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: Color(0xFFE5C9A8),
                border: Border.all(color: Color(0xFF1E100A), width: 1.0),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt,
                color: Color(0xFF3E2D16),
                size: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder({required this.login});

  final String login;

  @override
  Widget build(BuildContext context) {
    return Text(
      login.substring(0, 1).toUpperCase(),
      style: const TextStyle(
        color: Color(0xFF1E100A),
        fontSize: 36.0,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.0,
        height: 40.0 / 36.0,
      ),
    );
  }
}

class _LoadingAvatar extends StatelessWidget {
  const _LoadingAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 96.0,
      height: 96.0,
      decoration: BoxDecoration(
        color: Color(0xFF37261F),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({
    required this.login,
    required this.email,
    required this.createdAt,
  });

  final String login;
  final String email;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          login,
          style: TextStyle(
            color: Color(0xFFE5C9A8),
            fontSize: 24.0,
            fontWeight: FontWeight.normal,
            letterSpacing: -0.6,
            height: 32.0 / 24.0,
          ),
        ),

        const SizedBox(height: 4.0),

        Text(
          email,
          style: TextStyle(
            color: Color(0xFFE5C9A8),
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.0,
            height: 20.0 / 14.0,
          ),
        ),

        const SizedBox(height: 12.0),

        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.0,
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: Color(0xFFE5C9A8),
              size: 11.0,
            ),

            Text(
              MyLocale.of(context).profileUserInfoCreatedAt(
                DateFormat('dd MMMM yyyy').format(createdAt),
              ),
              style: const TextStyle(
                color: Color(0xFFE5C9A8),
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
                letterSpacing: 0.0,
                height: 16.0 / 12.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LoadingInfo extends StatelessWidget {
  const _LoadingInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF37261F),
            borderRadius: BorderRadius.circular(12.0),
          ),
          width: 143.5,
          height: 32.0,
        ),

        const SizedBox(height: 12.0),

        Container(
          decoration: BoxDecoration(
            color: Color(0xFF37261F),
            borderRadius: BorderRadius.circular(12.0),
          ),
          width: 204.0,
          height: 20.0,
        ),

        const SizedBox(height: 12.0),

        Container(
          decoration: BoxDecoration(
            color: Color(0xFF37261F),
            borderRadius: BorderRadius.circular(12.0),
          ),
          width: 175.0,
          height: 11.0,
        ),
      ],
    );
  }
}
