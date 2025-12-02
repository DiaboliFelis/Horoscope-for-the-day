import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horoscope_for_the_day/data/datasources/horoscope_data_source.dart';
import 'package:horoscope_for_the_day/service/horoscope_service.dart';
import 'package:intl/intl.dart';
import 'package:horoscope_for_the_day/presentation/blocs/horoscope_detail/horoscope_block.dart';
import 'package:horoscope_for_the_day/presentation/blocs/horoscope_detail/horoscope_state.dart';
import 'package:horoscope_for_the_day/presentation/blocs/horoscope_detail/horoscope_event.dart';

class HoroscopeDetailPage extends StatefulWidget {
  // Ожидаем получить знак зодиака
  final String zodiacSign;
  final HoroscopeDataSource horoscopeDataSource;

  // Конструктор должен принимать required параметр, чтобы мы могли передать его
  const HoroscopeDetailPage({
    Key? key,
    required this.zodiacSign,
    required this.horoscopeDataSource,
  }) : super(key: key);

  @override
  State<HoroscopeDetailPage> createState() => _HoroscopeDetailPageState();
}

class _HoroscopeDetailPageState extends State<HoroscopeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Оборачиваем виджет в BlocProvider
      // create: (context) => HoroscopeBloc(widget.horoscopeDataSource)
      //   ..add(FetchHoroscope(widget.zodiacSign)), // Отправляем событие при создании Bloc
      // Убедись, что ты используешь правильные пути импортов!
      // Если ты используешь freezed, то событие будет const HoroscopeEvent.fetch(widget.zodiacSign)
      create:
          (context) => HoroscopeBloc(widget.horoscopeDataSource)..add(
            FetchHoroscope(widget.zodiacSign),
          ), // Отправляем первое событие
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Horoscope for ${widget.zodiacSign}',
            style: TextStyle(color: Color.fromARGB(255, 244, 240, 245)),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        //backgroundColor: const Color.fromARGB(255, 22, 7, 34),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/sky.jpg'), // путь к вашему изображению
              fit: BoxFit.cover, // изображение покрывает весь экран
            ),
          ),
          child: BlocBuilder<HoroscopeBloc, HoroscopeState>(
            builder: (context, state) {
              // Теперь обрабатываем разные состояния, которые выдает Bloc
              if (state is HoroscopeLoading) {
                // 1. Состояние загрузки (было в FutureBuilder)
                return Center(
                  child: CircularProgressIndicator(strokeWidth: 3.0),
                );
              } else if (state is HoroscopeError) {
                // 2. Состояние ошибки (было в FutureBuilder)
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: ${state.message}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Повторно отправляем событие, чтобы попробовать загрузить данные снова
                          context.read<HoroscopeBloc>().add(
                            FetchHoroscope(widget.zodiacSign),
                          );
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (state is HoroscopeLoaded) {
                // 3. Состояние успеха (было в FutureBuilder)
                return SingleChildScrollView(
                  // Используем SingleChildScrollView, если текст может быть длинным
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/${widget.zodiacSign.toLowerCase()}.jpg',
                        width: 300, // можно задать размер
                        height: 300,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${DateFormat('d MMMM yyyy').format(DateTime.now())}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 244, 240, 245),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        state
                            .horoscopeText, // Отображаем полученный текст гороскопа
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          color: Color.fromARGB(255, 244, 240, 245),
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
      ),
    );
  }
}
