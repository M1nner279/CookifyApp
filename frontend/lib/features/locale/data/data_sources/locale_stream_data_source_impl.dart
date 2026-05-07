import 'dart:async';
import 'dart:ui';

import 'package:cookify/features/locale/data/data_sources/locale_stream_data_source.dart';

final class LocaleStreamDataSourceImpl implements LocaleStreamDataSource {
  final _controller = StreamController<Locale>.broadcast();

  @override
  Future<Stream<Locale>> listenLocale() async {
    return _controller.stream;
  }

  @override
  Future<void> addLocale(Locale locale) async {
    _controller.add(locale);
  }
}
