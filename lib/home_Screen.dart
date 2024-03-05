import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/WeatherCard.dart';
import 'package:weather_app/additional_Info.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class home_Screen extends StatefulWidget {
  const home_Screen({
    super.key,
  });

  @override
  State<home_Screen> createState() => _home_ScreenState();
}

class _home_ScreenState extends State<home_Screen> {
  bool isLoading = true;
  double currentTemp = 0;
  String currentSkyCondition = '';
  double currentWindSpeed = 0;
  double currentHumidity = 0;
  double currentPressure = 0;
  bool x = true;
  TextEditingController cityController = TextEditingController();

  String cityName = 'Gadag';
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<void> getCurrentWeather() async {
    try {
      String apiKey = 'b2b26e4192ad16d6e1da3f20f4400dcf';
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          currentTemp = (data['main']['temp'] - 273.15);
          isLoading = false;
          currentSkyCondition = data['weather'][0]['main'];
          currentPressure = data['main']['pressure'] / 100;
          currentHumidity = data['main']['humidity'].toDouble();
          currentWindSpeed = data['wind']['speed'];
        });
      } else {
        setState(() {
          currentTemp = 0;
          isLoading = false;
          currentSkyCondition = 'Sorry, cheak your input';
          currentPressure = 0;
          currentHumidity = 0;
          currentWindSpeed = 0;
          x = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          cityName[0].toUpperCase() + cityName.substring(1),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                getCurrentWeather();
                print("Refresh");
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              )),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          color: const Color.fromARGB(173, 202, 167, 178),
                          elevation: 15,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                x == false
                                    ? 'Data Not Found'
                                    : "${currentTemp.toStringAsFixed(2)} °C",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Icon(
                                currentSkyCondition == 'Clouds' ||
                                        currentSkyCondition == 'Mist' ||
                                        currentSkyCondition == 'Rain'
                                    ? Icons.cloud
                                    : Icons.wb_sunny,
                                size: 64,
                                color: currentSkyCondition == 'Clouds' ||
                                        currentSkyCondition == 'Mist' ||
                                        currentSkyCondition == 'Rain'
                                    ? Colors.blueGrey
                                    : Colors.yellow[700],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                currentSkyCondition,
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Daily Forecast",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        WeatherCard(
                          title: 'Sun',
                        ),
                        WeatherCard(
                          title: 'Mon',
                        ),
                        WeatherCard(
                          title: 'Tue',
                        ),
                        WeatherCard(
                          title: 'Wed',
                        ),
                        WeatherCard(
                          title: 'The',
                        ),
                        WeatherCard(
                          title: 'Fri',
                        ),
                        WeatherCard(
                          title: 'Sat',
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Additional Info",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        additional_Info(
                          title: 'Wind',
                          value: currentWindSpeed.toStringAsFixed(2),
                          icon: Icons.air,
                        ),
                        additional_Info(
                          title: 'Humidity',
                          value: currentHumidity.toStringAsFixed(2),
                          icon: Icons.water,
                        ),
                        additional_Info(
                          title: 'Pressure',
                          value: currentPressure.toStringAsFixed(2),
                          icon: Icons.arrow_downward,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 170,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Change Location',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  content: TextField(
                                    controller: cityController,
                                    decoration: const InputDecoration(
                                        hintText: 'Enter City Name'),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-zA-Z]'))
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          cityName = cityController.text;
                                          isLoading = true;
                                        });
                                        getCurrentWeather();
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    )
                                  ],
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'Change City',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
