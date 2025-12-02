import 'package:flutter/material.dart';

class ZodiacButton extends StatelessWidget {
  final String zodiacSign;
  final VoidCallback onPressed;

  const ZodiacButton({
    Key? key,
    required this.zodiacSign,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 244, 240, 245),
        ),
        child: Text(zodiacSign, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
