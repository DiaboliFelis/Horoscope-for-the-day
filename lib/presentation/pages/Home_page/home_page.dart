import 'package:flutter/material.dart';
import 'package:horoscope_for_the_day/presentation/pages/Home_page/widgets/buildZodiacButton.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? selectedDay;
  String? selectedMonth;
  int? selectedYear;
  String? zodiacSign;

  final List<String> zodiacSigns = [
    'Aries',
    'Taurus',
    'Gemini',
    'Cancer',
    'Leo',
    'Virgo',
    'Libra',
    'Scorpio',
    'Sagittarius',
    'Capricorn',
    'Aquarius',
    'Pisces',
  ];

  final List<int> days = List<int>.generate(31, (i) => i + 1);
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final List<int> years = List<int>.generate(100, (i) => 1920 + i);

  String getZodiacSign(int day, String month) {
    if ((month == 'January' && day >= 20) || (month == 'February' && day <= 18))
      return 'Aquarius';
    if ((month == 'February' && day >= 19) || (month == 'March' && day <= 20))
      return 'Pisces';
    if ((month == 'March' && day >= 21) || (month == 'April' && day <= 19))
      return 'Aries';
    if ((month == 'April' && day >= 20) || (month == 'May' && day <= 20))
      return 'Taurus';
    if ((month == 'May' && day >= 21) || (month == 'June' && day <= 20))
      return 'Gemini';
    if ((month == 'June' && day >= 21) || (month == 'July' && day <= 22))
      return 'Cancer';
    if ((month == 'July' && day >= 23) || (month == 'August' && day <= 22))
      return 'Leo';
    if ((month == 'August' && day >= 23) || (month == 'September' && day <= 22))
      return 'Virgo';
    if ((month == 'September' && day >= 23) ||
        (month == 'October' && day <= 22))
      return 'Libra';
    if ((month == 'October' && day >= 23) || (month == 'November' && day <= 21))
      return 'Scorpio';
    if ((month == 'November' && day >= 22) ||
        (month == 'December' && day <= 21))
      return 'Sagittarius';
    if ((month == 'December' && day >= 22) || (month == 'January' && day <= 19))
      return 'Capricorn';
    return 'Unknown';
  }

  void _calculateZodiac() {
    if (selectedDay != null && selectedMonth != null) {
      setState(() {
        zodiacSign = getZodiacSign(selectedDay!, selectedMonth!);
      });
    }
  }

  void _onSubmit() {
    if (selectedDay != null && selectedMonth != null && selectedYear != null) {
      String sign = getZodiacSign(selectedDay!, selectedMonth!);
      Navigator.pushNamed(
        context,
        'horoscope-detail',
        arguments: {'zodiacSign': sign},
      );
    } else {
      // уведомление о необходимости заполнить все поля
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, выберите все данные')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Horoscope for the day:',
          style: TextStyle(color: Color.fromARGB(255, 244, 240, 245)),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sky.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: List.generate((zodiacSigns.length / 2).ceil(), (
                      index,
                    ) {
                      int firstIndex = index * 2;
                      int secondIndex = firstIndex + 1;

                      return Row(
                        children: [
                          // Первая кнопка
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  'horoscope-detail',
                                  arguments: {
                                    'zodiacSign': zodiacSigns[firstIndex],
                                  },
                                );
                              },
                              child: Text(
                                zodiacSigns[firstIndex],
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(width: 8), // отступ между кнопками
                          // Вторая кнопка (если есть)
                          if (secondIndex < zodiacSigns.length)
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    'horoscope-detail',
                                    arguments: {
                                      'zodiacSign': zodiacSigns[secondIndex],
                                    },
                                  );
                                },
                                child: Text(
                                  zodiacSigns[secondIndex],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Первый Dropdown
                DropdownButton<int>(
                  hint: const Text(
                    'Day',
                    style: TextStyle(color: Color.fromARGB(255, 244, 240, 245)),
                  ),
                  value: selectedDay,
                  onChanged: (int? newVal) {
                    setState(() {
                      selectedDay = newVal;
                    });
                  },
                  dropdownColor: Colors.black, // Цвет фона выпадающего списка
                  style: TextStyle(
                    color: Color.fromARGB(255, 244, 240, 245),
                  ), // Цвет текста выбранного значения
                  items:
                      days.map((int day) {
                        return DropdownMenuItem<int>(
                          value: day,
                          child: Text(
                            '$day',
                            style: TextStyle(
                              color: Color.fromARGB(255, 244, 240, 245),
                            ),
                          ),
                        );
                      }).toList(),
                ),
                SizedBox(width: 30), // Расстояние между списками
                // Второй Dropdown
                DropdownButton<String>(
                  hint: const Text(
                    'Month',
                    style: TextStyle(color: Color.fromARGB(255, 244, 240, 245)),
                  ),
                  value: selectedMonth,
                  onChanged: (String? newVal) {
                    setState(() {
                      selectedMonth = newVal;
                    });
                  },
                  dropdownColor: Colors.black,
                  style: TextStyle(color: Color.fromARGB(255, 244, 240, 245)),
                  items:
                      months.map((String month) {
                        return DropdownMenuItem<String>(
                          value: month,
                          child: Text(
                            month,
                            style: TextStyle(
                              color: Color.fromARGB(255, 244, 240, 245),
                            ),
                          ),
                        );
                      }).toList(),
                ),
                SizedBox(width: 30),
                // Третий Dropdown
                DropdownButton<int>(
                  hint: const Text(
                    'Year',
                    style: TextStyle(color: Color.fromARGB(255, 244, 240, 245)),
                  ),
                  value: selectedYear,
                  onChanged: (int? newVal) {
                    setState(() {
                      selectedYear = newVal;
                    });
                  },
                  dropdownColor: Colors.black,
                  style: TextStyle(color: Color.fromARGB(255, 244, 240, 245)),
                  items:
                      years.map((int year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(
                            '$year',
                            style: TextStyle(
                              color: Color.fromARGB(255, 244, 240, 245),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),

            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _onSubmit,
              child: Text(
                'View your zodiac sign',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
