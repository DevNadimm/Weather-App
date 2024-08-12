import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controller/weather_api_service.dart';
import '../../models/get_weather_icon.dart';
import '../widgets/additional_info_container.dart';
import '../widgets/main_container.dart';
import '../widgets/weather_forecast_container.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherApiService _apiService = WeatherApiService();

  Future<void> _refreshWeatherData() async {
    setState(() {});
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
      ),
      body: FutureBuilder(
        future: _apiService.getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available.'));
          }

          final data = snapshot.data!;
          var currentTemp = (data['list'][0]['main']['temp']) - 273.15;
          var currentSky = data['list'][0]['weather'][0]['main'];
          var humidity = data['list'][1]['main']['humidity'].toString();
          var pressure = data['list'][1]['main']['pressure'].toString();
          var windSpeed = data['list'][1]['wind']['speed'].toString();

          final weatherIcon = getWeatherIcon(currentSky);

          return RefreshIndicator(
            onRefresh: _refreshWeatherData,
            backgroundColor: Colors.blueGrey,
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                MainContainer(
                  icon: weatherIcon,
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
                      num: '$humidity%',
                    ),
                    AdditionalInfoContainer(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      num: '$windSpeed km/h',
                    ),
                    AdditionalInfoContainer(
                      icon: Icons.waves,
                      label: 'Pressure',
                      num: '$pressure mb',
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
