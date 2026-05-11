import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:cookify/features/profile/presentation/bloc/profile_event.dart';
import 'package:cookify/features/profile/presentation/widgets/profile_settings_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key, required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MyLocale.of(context).profileSettings,
          style: const TextStyle(
            color: Color(0xFFFADCD2),
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.35,
            height: 20.0 / 14.0,
          ),
        ),

        const SizedBox(height: 12.0),

        ProfileSettingsLocale(locale: locale),

        const SizedBox(height: 12.0),

        const _ChangePasswordButton(),

        const SizedBox(height: 12.0),

        const _SignoutButton(),
      ],
    );
  }
}

class _ChangePasswordButton extends StatelessWidget {
  const _ChangePasswordButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProfileBloc>().add(const PushChangePassword());
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2C1C16),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          spacing: 16.0,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF43312A),
                borderRadius: BorderRadius.circular(8.0),
              ),
              width: 40.0,
              height: 40.0,
              child: const Icon(Icons.lock, color: Color(0xFFE5C9A8)),
            ),

            Expanded(
              child: Text(
                MyLocale.of(context).profileSettingsChangePassword,
                style: const TextStyle(
                  color: Color(0xFFFADCD2),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.0,
                  height: 20.0 / 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignoutButton extends StatelessWidget {
  const _SignoutButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProfileBloc>().add(const Signout());
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF271812),
          border: Border.all(
            color: const Color(0xFF83260E).withAlpha((255 * 0.2).toInt()),
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          spacing: 16.0,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF83260E).withAlpha((255 * 0.2).toInt()),
                borderRadius: BorderRadius.circular(8.0),
              ),
              width: 40.0,
              height: 40.0,
              child: const Icon(Icons.logout, color: Color(0xFFFFB4AB)),
            ),

            Expanded(
              child: Text(
                MyLocale.of(context).profileSettingsSignout,
                style: const TextStyle(
                  color: Color(0xFFFFB4AB),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.0,
                  height: 20.0 / 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
