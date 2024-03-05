import 'package:flutter/material.dart';

// ignore: camel_case_types, must_be_immutable
class additional_Info extends StatelessWidget {
  String title = '';
  String value = '';
  IconData icon;
  additional_Info(
      {super.key,
      required this.title,
      required this.value,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Center(
        child: SizedBox(
          width: 110,
          child: Card(
            color: const Color.fromARGB(173, 202, 167, 178),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
            child: Container(
                width: 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Icon(
                        icon,
                        size: 32,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        title,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        value,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
