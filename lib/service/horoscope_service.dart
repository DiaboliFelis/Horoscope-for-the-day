import 'package:dio/dio.dart';

class HoroscopeService {
  final Dio _dio;

  static const String _baseUrl = 'https://api.api-ninjas.com/v1';
  static const String _apiKey = 'gq4cOTQOoTtUqPMkHC+bqQ==tF98Aau1LifrLep8';

  HoroscopeService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          headers: {'X-Api-Key': _apiKey, 'Content-Type': 'application/json'},
        ),
      );

  // Общий метод GET
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get(endpoint, queryParameters: queryParameters);
  }

  Future<Response> post(String endpoint, {dynamic data}) {
    return _dio.post(endpoint, data: data);
  }
}
