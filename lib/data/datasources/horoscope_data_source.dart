import 'dart:convert';
import '../../service/horoscope_service.dart';
import 'package:dio/dio.dart';

class HoroscopeDataSource {
  final HoroscopeService service;

  HoroscopeDataSource({required this.service});

  Future<String> fetchHoroscope(String zodiacSign) async {
    final response = await service.get(
      '/horoscope',
      queryParameters: {'zodiac': zodiacSign.toLowerCase()},
    );

    print('Response status: ${response.statusCode}');
    print('Response data: ${response.data}');
    print('Response data type: ${response.data.runtimeType}');

    if (response.statusCode == 200) {
      final data = response.data;
      if (data is Map<String, dynamic>) {
        if (data.containsKey('horoscope') && data['horoscope'] is String) {
          return data['horoscope'];
        } else {
          print('Неожиданная структура ответа: $data');
          return 'Не удалось получить гороскоп.';
        }
      } else if (data is String) {
        // Если ответ — это строка, возвращайте её напрямую или обработайте
        return data;
      } else {
        print('Неожиданный тип данных: ${data.runtimeType}');
        return 'Некорректный ответ сервера.';
      }
    } else {
      print(
        'Ошибка API: Статус ${response.statusCode}, Ответ: ${response.data}',
      );
      return 'Ошибка получения данных. Статус: ${response.statusCode}';
    }
  }
}
