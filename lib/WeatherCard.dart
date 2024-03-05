import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WeatherCard extends StatelessWidget {
  String title = '';
  WeatherCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        width: 100,
        child: Card(
          color: const Color.fromARGB(173, 202, 167, 178),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
          child: Container(
              width: 120,
              child: Column(
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Icon(
                    Icons.wb_sunny,
                    size: 32,
                    color: Colors.orange,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "26 °C",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
