import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widgets/additional_info_container.dart';
import 'package:weather_app/widgets/get_current_icon.dart';
import 'package:weather_app/widgets/main_container.dart';
import 'package:weather_app/widgets/weather_forecast_container.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      const String location = 'Dhaka';
      const String apiKey = '073e067ecb7de3ac02d3614cca930816';

      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$location&APPID=$apiKey'),
      );
      final data = jsonDecode(res.body);

      if (res.statusCode != 200) {
        throw Exception('HTTP request failed with status: ${res.statusCode}');
      }

      return data;
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          var currentTemp = (data['list'][0]['main']['temp']) - 273.15;
          var currentSky = data['list'][0]['weather'][0]['main'];
          var humidity = data['list'][1]['main']['humidity'].toString();
          var pressure = data['list'][1]['main']['pressure'].toString();
          var windSpeed = data['list'][1]['wind']['speed'].toString();

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainContainer(
                  icon: getWeatherIcon(currentSky),
                  label: currentSky,
                  temp: '${currentTemp.toStringAsFixed(2)}° C',
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Weather Forecast',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 125,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      final forecastData = data['list'][index + 1];
                      final forecastTemp =
                          forecastData['main']['temp'] - 273.15;
                      final forecastTime =
                          DateTime.parse(forecastData['dt_txt']);
                      final forecastIcon = getWeatherIcon(
                        forecastData['weather'][0]['main'].toString(),
                      );
                      return WeatherForecastContainer(
                        time: DateFormat.j().format(forecastTime),
                        icon: forecastIcon,
                        temp: '${forecastTemp.toStringAsFixed(1)}°',
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoContainer(
                      icon: Icons.water_drop_rounded,
                      label: 'Humidity',
                      num: humidity,
                    ),
                    AdditionalInfoContainer(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      num: windSpeed,
                    ),
                    AdditionalInfoContainer(
                      icon: Icons.waves,
                      label: 'Pressure',
                      num: pressure,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
