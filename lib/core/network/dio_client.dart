import 'dart:developer';

import 'package:dio/dio.dart';

class DioClient {
  Dio? _dio;
  final String baseUrl;
  final bool hasAuthorization;

  DioClient({required this.baseUrl, this.hasAuthorization = false}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 30000),
        receiveTimeout: Duration(milliseconds: 25000),
      ),
    );
  }

  static const int timeoutDuration = 1;

  Future<Response> getRequest(
    urlEndPoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response;

    response = await _dio!
        .get(urlEndPoint, queryParameters: queryParameters)
        .timeout(const Duration(minutes: timeoutDuration));

    log(
      "API Get Response: $response || Endpoint: $urlEndPoint || QueryParams: $queryParameters",
    );

    return response;
  }

  Future<Response> post(
    urlEndpoint, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response;

    response = await _dio!
        .post(urlEndpoint, data: data, queryParameters: queryParameters)
        .timeout(const Duration(minutes: timeoutDuration));

    log(
      "API Post Response: $response || Endpoint: $urlEndpoint || Data: $data || QueryParams: $queryParameters",
    );
    return response;
  }

  Future<Response> put(
    urlEndpoint, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response;

    response = await _dio!
        .put(urlEndpoint, data: data, queryParameters: queryParameters)
        .timeout(const Duration(minutes: timeoutDuration));

    return response;
  }

  Future<Response> delete(
    urlEndpoint, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response;

    response = await _dio!
        .delete(urlEndpoint, data: data, queryParameters: queryParameters)
        .timeout(const Duration(minutes: timeoutDuration));

    return response;
  }

  Future<Response> patch(
    urlEndpoint, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response;

    response = await _dio!
        .patch(urlEndpoint, data: data, queryParameters: queryParameters)
        .timeout(const Duration(minutes: timeoutDuration));

    return response;
  }
}

extension ResponseExt on Response {
  bool get isSuccessful => statusCode! >= 200 && statusCode! < 300;

  get body => data;
}

String errorDefaultMessage = "⚠️ Your request failed. Kindly retry again.";

String networkErrorHandler(
  DioException error, {
  Function(DioException e)? onResponseError,
}) {
  switch (error.type) {
    case DioExceptionType.badResponse:
      if (onResponseError == null && error.response != null) {
        log("API Error Response ${error.response}");

        if (error.response?.statusCode == 500) {
          return errorDefaultMessage;
        }

        if (error.response?.statusCode == 404) {
          return error.response?.data["message"] ?? errorDefaultMessage;
        }

        if (error.response?.statusCode == 400) {
          return error.response?.data["message"] ?? errorDefaultMessage;
        }

        if (error.response?.data != null) {
          return error.response?.data["message"];
        } else {
          return errorDefaultMessage;
        }
      }
      return onResponseError!(error);

    case DioExceptionType.connectionTimeout:
      return "Kindly try again";
    case DioExceptionType.sendTimeout:
      return "Check your internet connection";
    case DioExceptionType.receiveTimeout:
      return "Check your internet connection";
    case DioExceptionType.cancel:
      return "Request cancelled";
    case DioExceptionType.unknown:
      return "No Internet Connection";
    default:
      return errorDefaultMessage;
  }
}
