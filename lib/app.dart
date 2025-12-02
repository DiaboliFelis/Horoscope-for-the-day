import 'package:flutter/material.dart';
import 'package:horoscope_for_the_day/presentation/pages/Home_page/home_page.dart';
import 'package:horoscope_for_the_day/presentation/pages/Horoscope_detail_page/horoscope_detail_page.dart';
import 'package:horoscope_for_the_day/presentation/blocs/horoscope_detail/horoscope_block.dart';
import 'package:horoscope_for_the_day/presentation/blocs/horoscope_detail/horoscope_state.dart';
import 'package:horoscope_for_the_day/presentation/blocs/horoscope_detail/horoscope_event.dart';
import 'package:horoscope_for_the_day/data/datasources/horoscope_data_source.dart';
import 'package:horoscope_for_the_day/service/horoscope_service.dart';

class MyApp extends StatelessWidget {
  final HoroscopeDataSource horoscopeDataSource = HoroscopeDataSource(
    service: HoroscopeService(),
  );

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horoscope for the day',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        'horoscope-detail': (context) {
          // Получаем аргументы, переданные при вызове Navigator.pushNamed
          final args = ModalRoute.of(context)?.settings.arguments;

          // Проверяем, что аргументы переданы и имеют ожидаемый формат
          if (args is Map<String, dynamic> && args.containsKey('zodiacSign')) {
            // Если все в порядке, создаем HoroscopeDetailPage с переданным знаком зодиака
            return HoroscopeDetailPage(
              zodiacSign: args['zodiacSign'] as String,
              horoscopeDataSource: horoscopeDataSource,
            );
          } else {
            return HoroscopeDetailPage(
              zodiacSign: 'Invalid arguments',
              horoscopeDataSource: horoscopeDataSource,
            );
          }
        },
      },
    );
  }
}
