import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
sealed class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.init() = InitProfile;

  const factory ProfileEvent.updateAvatar({required File avatarFile}) =
      UpdateAvatar;

  const factory ProfileEvent.changeLocale({required Locale locale}) = ChangeLocale;

  const factory ProfileEvent.pushChangePassword() = PushChangePassword;

  const factory ProfileEvent.signout() = Signout;
}
