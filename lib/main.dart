import 'package:flutter/material.dart';
import 'package:weather_app/home_Screen.dart';

void main() {
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(
      
    )));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const home_Screen();
  }
}

