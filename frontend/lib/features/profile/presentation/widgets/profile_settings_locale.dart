import 'package:cookify/core/l10n/app_localizations.dart';
import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:cookify/features/profile/presentation/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSettingsLocale extends StatefulWidget {
  const ProfileSettingsLocale({super.key, required this.locale});

  final Locale locale;

  @override
  State<ProfileSettingsLocale> createState() => _ProfileSettingsLocaleState();
}

class _ProfileSettingsLocaleState extends State<ProfileSettingsLocale> {
  static const _duration = Duration(milliseconds: 150);

  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2C1C16),
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isOpen = !_isOpen;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: _isOpen
                    ? Border(
                        bottom: BorderSide(
                          color: const Color(
                            0xFF4D453D,
                          ).withAlpha((0.2 * 255).toInt()),
                        ),
                      )
                    : null,
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
                    child: const Icon(Icons.language, color: Color(0xFFE5C9A8)),
                  ),

                  Expanded(
                    child: Text(
                      MyLocale.of(context).profileSettingsLocale,
                      style: const TextStyle(
                        color: Color(0xFFFADCD2),
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.0,
                        height: 20.0 / 14.0,
                      ),
                    ),
                  ),

                  AnimatedRotation(
                    turns: _isOpen ? 1 / 4 : 0,
                    curve: Curves.easeInOut,
                    duration: _duration,
                    child: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Color(0xFFE5C9A8),
                    ),
                  ),
                ],
              ),
            ),

            ClipRect(
              child: AnimatedSize(
                curve: Curves.easeInOut,
                duration: _duration,
                child: _isOpen
                    ? Container(
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF271812,
                          ).withAlpha((0.5 * 255).toInt()),
                        ),
                        child: Column(
                          children: AppLocalizations.supportedLocales
                              .map(
                                (locale) => _Locale(
                                  isSelected: widget.locale == locale,
                                  locale: locale,
                                ),
                              )
                              .toList(),
                        ),
                      )
                    : const SizedBox(width: double.infinity),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Locale extends StatelessWidget {
  const _Locale({required this.isSelected, required this.locale});

  final bool isSelected;
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProfileBloc>().add(ChangeLocale(locale: locale));
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: isSelected ? 16.0 : 32.0,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE5C9A8).withAlpha((0.1 * 255).toInt())
              : null,
          border: isSelected
              ? Border(left: BorderSide(color: Color(0xFFFFE6C9), width: 4.0))
              : null,
        ),
        child: Row(
          spacing: 16.0,
          children: [
            if (isSelected)
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE6C9),
                  shape: BoxShape.circle,
                ),
                width: 8.0,
                height: 8.0,
              ),

            Expanded(
              child: Text(
                switch (locale.languageCode) {
                  'ru' => 'Русский',
                  'en' => 'English',
                  _ => throw UnimplementedError(),
                },
                style: TextStyle(
                  color: isSelected
                      ? const Color(0xFFFADCD2)
                      : const Color(0xFFD1C4B9),
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.0,
                  height: 20.0 / 14.0,
                ),
              ),
            ),

            if (isSelected)
              const Icon(Icons.check, color: Color(0xFFFFE6C9), size: 16.0),
          ],
        ),
      ),
    );
  }
}
