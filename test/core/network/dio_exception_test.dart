import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fin_hub/core/network/dio_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('handleDioError returns network error message', () {
    final exception = DioException(
      type: DioExceptionType.connectionError,
      error: const SocketException('No Internet'),
      requestOptions: RequestOptions(path: '/'),
    );

    final result = handleDioError(exception);
    expect(result, contains("No internet connection"));
  });
}
