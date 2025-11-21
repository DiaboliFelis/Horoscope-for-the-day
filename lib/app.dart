import 'package:flutter/material.dart';
import 'package:horoscope_for_the_day/presentation/pages/home_page.dart';
import 'package:horoscope_for_the_day/presentation/pages/horoscope_detail_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horoscope for the day',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 157, 114, 232),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
      routes: {
        'horoscope-detail': (context) {
          // Получаем аргументы, переданные при вызове Navigator.pushNamed
          final args = ModalRoute.of(context)?.settings.arguments;

          // Проверяем, что аргументы переданы и имеют ожидаемый формат
          if (args is Map<String, dynamic> && args.containsKey('zodiacSign')) {
            // Если все в порядке, создаем HoroscopeDetailPage с переданным знаком зодиака
            return HoroscopeDetailPage(
              zodiacSign: args['zodiacSign'] as String,
            );
          } else {
            return const HoroscopeDetailPage(zodiacSign: 'Invalid arguments');
          }
        },
      },
    );
  }
}
