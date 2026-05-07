import 'package:cookify/core/data/mappers/failure_mapper.dart';
import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/locale/data/data_sources/locale_local_data_source.dart';
import 'package:cookify/features/locale/data/data_sources/locale_stream_data_source.dart';
import 'package:cookify/features/locale/data/mappers/set_locale_mapper.dart';
import 'package:cookify/features/locale/domain/payloads/set_locale_payload.dart';
import 'package:cookify/features/locale/domain/repositories/locale_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

final class LocaleRepositoryImpl implements LocaleRepository {
  LocaleRepositoryImpl({
    required LocaleLocalDataSource localDataSource,
    required LocaleStreamDataSource streamDataSource,
  }) : _localDataSource = localDataSource,
       _streamDataSource = streamDataSource;

  final LocaleLocalDataSource _localDataSource;
  final LocaleStreamDataSource _streamDataSource;

  @override
  Future<MyEither<Locale?>> getLocale() async {
    try {
      final locale = await _localDataSource.getLocale();

      return Right(locale == null ? null : Locale(locale));
    } on Exception catch (e) {
      return Left(FailureMapper.toFailure(e));
    }
  }

  @override
  Future<MyEither<Locale>> setLocale(SetLocalePayload payload) async {
    try {
      final request = SetLocaleMapper.toRequest(payload);
      final locale = await _localDataSource.setLocale(request);

      return Right(Locale(locale));
    } on Exception catch (e) {
      return Left(FailureMapper.toFailure(e));
    }
  }

  @override
  Future<MyEither<Stream<Locale>>> listenLocale() async {
    try {
      final stream = await _streamDataSource.listenLocale();

      return Right(stream);
    } on Exception catch (e) {
      return Left(FailureMapper.toFailure(e));
    }
  }

  @override
  Future<MyEither<void>> addLocaleToStream(Locale locale) async {
    try {
      await _streamDataSource.addLocale(locale);

      return Right(null);
    } on Exception catch (e) {
      return Left(FailureMapper.toFailure(e));
    }
  }
}
