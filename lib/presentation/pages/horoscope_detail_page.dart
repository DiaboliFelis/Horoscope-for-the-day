import 'package:flutter/material.dart';
import 'package:horoscope_for_the_day/services/horoscope_service.dart';

class HoroscopeDetailPage extends StatefulWidget {
  // Ожидаем получить знак зодиака
  final String zodiacSign;

  // Конструктор должен принимать required параметр, чтобы мы могли передать его
  const HoroscopeDetailPage({Key? key, required this.zodiacSign})
    : super(key: key);

  @override
  State<HoroscopeDetailPage> createState() => _HoroscopeDetailPageState();
}

class _HoroscopeDetailPageState extends State<HoroscopeDetailPage> {
  late Future<String>
  _horoscopeFuture; // Хранилище для нашего будущего (данных)
  final HoroscopeService _service = HoroscopeService();

  @override
  void initState() {
    super.initState();
    // При инициализации состояния, запускаем загрузку данных
    _horoscopeFuture = _service.fetchHoroscope(widget.zodiacSign);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Color.fromARGB(255, 219, 140, 229)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 22, 7, 34),
      ),
      backgroundColor: const Color.fromARGB(255, 22, 7, 34),
      body: Center(
        child: FutureBuilder<String>(
          future: _horoscopeFuture, // Какое асинхронное событие мы ждем
          builder: (context, snapshot) {
            // 1. Если данные еще загружаются (ожидание)
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                strokeWidth: 3.0,
              ); // Показываем спиннер
            }

            // 2. Если произошла ошибка
            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Ошибка загрузки: ${snapshot.error}'),
              );
            }

            // 3. Если данные загружены успешно (snapshot.hasData == true)
            if (snapshot.hasData) {
              return SingleChildScrollView(
                // Используем SingleChildScrollView, если текст может быть длинным
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Гороскоп для знака зодиака ${widget.zodiacSign}:',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 219, 140, 229),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      snapshot.data!, // Отображаем полученный текст гороскопа
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        color: Color.fromARGB(255, 219, 140, 229),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              );
            }

            // 4. Если нет данных и нет ошибки (крайне редкий случай)
            return const Text('No horoscope data available.');
          },
        ),
      ),
    );
  }
}
