import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather () async {
    String cityName = 'Chittagong';
    final res = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=073e067ecb7de3ac02d3614cca930816'),
    );
    if (kDebugMode) { 
      print(res.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('Chittagong'),
              const SizedBox(height: 20),
              _buildTemperatureInfo(Icons.foggy, '31°', 'Foggy', '35°', '27°'),
              const SizedBox(height: 20),
              _buildTodayWeather(),
              const SizedBox(height: 20),
              _buildNextForecast(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String location) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              location,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        const Icon(Icons.notifications, color: Colors.white),
      ],
    );
  }

  Widget _buildTemperatureInfo(IconData icon, String temp, String weather,
      String maxTemp, String minTemp) {
    return Center(
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 100),
          Text(
            temp,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 80,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            weather,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            'Max.: $maxTemp Min.: $minTemp',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayWeather() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildWeatherInfo('15.00', '29°'),
          _buildWeatherInfo('16.00', '26°'),
          _buildWeatherInfo('17.00', '24°', isCurrent: true),
          _buildWeatherInfo('18.00', '23°'),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(String time, String temperature,
      {bool isCurrent = false}) {
    return Column(
      children: [
        Text(
          time,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Icon(Icons.wb_sunny,
            color: isCurrent ? Colors.white : Colors.white, size: 32),
        const SizedBox(height: 4),
        Text(
          temperature,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildNextForecast() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Next Forecast',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 16),
            _buildForecastItem('Monday', '13°', '10°', Icons.wb_cloudy),
            _buildForecastItem('Tuesday', '15°', '12°', Icons.wb_sunny),
            // Add more forecast items here
          ],
        ),
      ),
    );
  }

  Widget _buildForecastItem(
      String day, String maxTemp, String minTemp, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                '$maxTemp / $minTemp',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
