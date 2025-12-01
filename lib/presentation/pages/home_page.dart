import 'package:flutter/material.dart';

// Функция для создания кнопки знака зодиака
Widget _buildZodiacButton({
  required BuildContext context, // Контекст нужен для навигации
  required String zodiacSign, // Название знака зодиака (обязательный параметр)
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          'horoscope-detail',
          arguments: {'zodiacSign': zodiacSign},
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 219, 140, 229),
      ),
      child: Text(zodiacSign, style: TextStyle(color: Colors.black)),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Гороскоп на день:',
          style: TextStyle(color: Color.fromARGB(255, 219, 140, 229)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 22, 7, 34),
      ),
      backgroundColor: const Color.fromARGB(255, 22, 7, 34),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildZodiacButton(context: context, zodiacSign: 'Овен'),
                      _buildZodiacButton(context: context, zodiacSign: 'Телец'),
                      _buildZodiacButton(
                        context: context,
                        zodiacSign: 'Близнецы',
                      ),
                      _buildZodiacButton(context: context, zodiacSign: 'Рак'),
                      _buildZodiacButton(context: context, zodiacSign: 'Лев'),
                      _buildZodiacButton(context: context, zodiacSign: 'Дева'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      _buildZodiacButton(context: context, zodiacSign: 'Весы'),
                      _buildZodiacButton(
                        context: context,
                        zodiacSign: 'Скорпион',
                      ),
                      _buildZodiacButton(
                        context: context,
                        zodiacSign: 'Стрелец',
                      ),
                      _buildZodiacButton(
                        context: context,
                        zodiacSign: 'Козерог',
                      ),
                      _buildZodiacButton(
                        context: context,
                        zodiacSign: 'Водолей',
                      ),
                      _buildZodiacButton(context: context, zodiacSign: 'Рыбы'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
