// Абстрактный класс для всех событий, связанных с гороскопом
abstract class HoroscopeEvent {}

// Событие для запроса гороскопа
class FetchHoroscope extends HoroscopeEvent {
  final String zodiacSign; // Какой знак зодиака нам нужен

  FetchHoroscope(this.zodiacSign);
}
