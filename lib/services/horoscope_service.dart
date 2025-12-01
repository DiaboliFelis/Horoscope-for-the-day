import 'dart:convert';
import 'package:http/http.dart' as http;

class HoroscopeService {
  static const String _baseUrl = 'https://api-ninjas.com/api/horoscope';
  static const String _apiKey = 'gq4cOTQOoTtUqPMkHC+bqQ==tF98Aau1LifrLep8';

  Map<String, String> zodiacTranslations = {
    'овен': 'aries',
    'телец': 'taurus',
    'близнецы': 'gemini',
    'рак': 'cancer',
    'лев': 'leo',
    'дева': 'virgo',
    'весы': 'libra',
    'скорпион': 'scorpio',
    'стрелец': 'sagittarius',
    'козерог': 'capricorn',
    'водолей': 'aquarius',
    'рыбы': 'pisces',
  };

  Future<String> fetchHoroscope(String zodiacSign) async {
    final String url =
        'https://api.api-ninjas.com/v1/horoscope?zodiac=${zodiacTranslations[zodiacSign.toLowerCase()]}';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'X-Api-Key': _apiKey},
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data.containsKey('horoscope') && data['horoscope'] is String) {
          return data['horoscope'];
        } else {
          // Если структура другая или отсутствует поле
          print('Неожиданная структура ответа: $data');
          return 'Не удалось получить гороскоп.';
        }
      } else {
        print(
          'Ошибка API: Статус ${response.statusCode}, Ответ: ${response.body}',
        );
        return 'Ошибка получения данных. Статус: ${response.statusCode}';
      }
    } catch (e) {
      print('Ошибка сети: $e');
      return 'Ошибка сети: $e';
    }
  }
}
