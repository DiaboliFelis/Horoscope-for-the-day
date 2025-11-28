import 'dart:convert';
import 'package:http/http.dart' as http;

class HoroscopeService {
  // Базовый URL API на RapidAPI
  static const String _baseUrl =
      'https://astropredict-daily-horoscopes-lucky-insights.p.rapidapi.com';

  static const String _apiKey =
      '0a05c7ba88msh90a9456c27eee98p1381c7jsnb2d921dacfe0';

  // Это хост API, который также требуется RapidAPI
  static const String _apiHost =
      'astropredict-daily-horoscopes-lucky-insights.p.rapidapi.com';

  Future<String> fetchHoroscope(String zodiacSign) async {
    // 1. Формируем URL
    // Получаем текущую дату в формате YYYY-MM-DD
    final now = DateTime.now();
    final String formattedDate =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    // Используем GET-запрос с параметрами: знак и дата
    // Обратите внимание, что зодиак должен быть в нижнем регистре
    final url = Uri.parse(
      '$_baseUrl/get-daily-horoscope?sign=${zodiacSign.toLowerCase()}&lucky_date=$formattedDate',
    );

    try {
      // 2. Выполняем GET-запрос с заголовками RapidAPI
      final response = await http.get(
        url,
        headers: {
          'X-RapidAPI-Key': _apiKey,
          'X-RapidAPI-Host': _apiHost,
          // Возможно, здесь понадобится еще один заголовок, если API его требует,
          // например, для конкретного endpoint ID, но обычно он не передается в заголовках.
        },
      );

      if (response.statusCode == 200) {
        // 3. Успешный ответ
        final Map<String, dynamic> data = jsonDecode(response.body);

        // 4. Извлекаем нужный текст из ответа.
        // ВАЖНО: В Playground на RapidAPI есть раздел "Response" или "Example Response".
        // Посмотрите, как выглядит JSON-ответ, чтобы правильно извлечь данные.
        // Пример: если ответ выглядит как { "horoscope": "Текст гороскопа..." }
        if (data.containsKey('horoscope') && data['horoscope'] is String) {
          return data['horoscope'];
        }
        // Если структура другая, например:
        // {
        //   "message": "success",
        //   "data": {
        //     "aries": {
        //       "date": "2024-01-20",
        //       "horoscope": "Текст..."
        //     }
        //   }
        // }
        // Тогда извлечение будет таким:
        else if (data.containsKey('data') &&
            data['data'][zodiacSign.toLowerCase()] != null &&
            data['data'][zodiacSign.toLowerCase()]['horoscope'] is String) {
          return data['data'][zodiacSign.toLowerCase()]['horoscope'];
        }
        // Если вы не уверены, распечатайте весь JSON:
        // print('Full response data: $data');
        // И посмотрите на структуру, чтобы понять, как извлечь данные.
        else {
          // Если структура ответа не соответствует ожиданиям
          print(
            'Unexpected response structure. Full data: $data',
          ); // Логируем для отладки
          return 'Error: Could not parse horoscope data from response.';
        }
      } else {
        // 5. Ошибка на стороне сервера или клиента
        print(
          'API Error: Status code ${response.statusCode}, Response: ${response.body}',
        );
        return 'Error: Failed to load data. Status code: ${response.statusCode}';
      }
    } catch (e) {
      // 6. Ошибка сети
      print('Network Error: $e');
      return 'Network Error: $e';
    }
  }
}
