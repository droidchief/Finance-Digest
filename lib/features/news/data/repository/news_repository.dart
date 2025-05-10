import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/app_config.dart';
import '../../../../core/network/dio_client.dart';
import '../models/news_model.dart';

class NewsRepository {
  final _client = DioClient().dio;
  static const _apiKey = apiToken;

  Future<List<NewsModel>> fetchNews() async {
    try {
      final response = await _client.get(
        '/api/v1/news',
        queryParameters: {
          'category': 'general',
          'token': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        debugPrint("Fetch news success ${data}");
        return data.map((json) => NewsModel.fromJson(json)).toList();
      } else {
        debugPrint("Fetch news error");
        throw Exception('Failed to load news');
      }
    } on DioException catch (e) {
      throw Exception('API Error: ${e.message}');
    }
  }
}
