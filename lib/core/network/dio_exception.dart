import 'package:dio/dio.dart';

String handleHttpError(int? statusCode) {
  switch (statusCode) {
    case 401:
      return "Access denied. Please check your credentials.";
    case 404:
      return "Page not found. Please try again later.";
    default:
      return "Something went wrong";
  }
}

String handleDioError(DioException e) {
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout) {
    return "Your network is unstable. Please try again.";
  } else if (e.type == DioExceptionType.connectionError ||
      e.message?.contains('Network is unreachable') == true ||
      e.error.toString().contains('SocketException')) {
    return "No internet connection. Please check your network.";
  } else if (e.response != null) {
    return handleHttpError(e.response?.statusCode);
  } else {
    return "Something went wrong";
  }
}

class CustomException implements Exception {
  final String message;
  CustomException(this.message);

  @override
  String toString() => message;
}

