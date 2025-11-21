import 'package:flutter/material.dart';

class HoroscopeDetailPage extends StatelessWidget {
  // Ожидаем получить знак зодиака
  final String zodiacSign;

  // Конструктор должен принимать required параметр, чтобы мы могли передать его
  const HoroscopeDetailPage({Key? key, required this.zodiacSign})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horoscope for $zodiacSign'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Your horoscope for $zodiacSign',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
