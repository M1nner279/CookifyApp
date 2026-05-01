import 'dart:async';

import 'package:cookify/features/token/data/data_sources/token_stream_data_source.dart';
import 'package:cookify/features/token/domain/enums/token_status.dart';

final class TokenStreamDataSourceImpl implements TokenStreamDataSource {
  final StreamController<TokenStatus> _controller =
      StreamController<TokenStatus>.broadcast();

  @override
  Future<Stream<TokenStatus>> getTokenStream() async {
    return _controller.stream;
  }

  @override
  Future<void> markTokenAsInvalid() async {
    _controller.add(TokenStatus.invalid);
  }
}
