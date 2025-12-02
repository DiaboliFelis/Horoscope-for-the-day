// Абстрактный класс для всех состояний экрана гороскопа
abstract class HoroscopeState {}

// Состояние: данные еще загружаются
class HoroscopeLoading extends HoroscopeState {}

// Состояние: произошла ошибка
class HoroscopeError extends HoroscopeState {
  final String message; // Сообщение об ошибке
  HoroscopeError(this.message);
}

// Состояние: данные успешно загружены
class HoroscopeLoaded extends HoroscopeState {
  final String horoscopeText; // Текст гороскопа
  HoroscopeLoaded(this.horoscopeText);
}
