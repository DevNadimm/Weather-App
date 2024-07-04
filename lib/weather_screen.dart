import 'package:flutter/material.dart';
import 'package:weather_app/widgets/additional_info_container.dart';
import 'package:weather_app/widgets/main_container.dart';
import 'package:weather_app/widgets/weather_forecast_container.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainContainer(
              icon: Icons.cloud,
              label: 'Cloudy',
              temp: '27.5° C',
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Weather Forecast',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  WeatherForecastContainer(
                    icon: Icons.cloud,
                    time: '09:00',
                    temp: '27.5°',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  WeatherForecastContainer(
                    icon: Icons.foggy,
                    time: '12:00',
                    temp: '27.9°',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  WeatherForecastContainer(
                    icon: Icons.sunny_snowing,
                    time: '15:00',
                    temp: '28.23°',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  WeatherForecastContainer(
                    icon: Icons.sunny,
                    time: '18:00',
                    temp: '29.1°',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  WeatherForecastContainer(
                    icon: Icons.cloud,
                    time: '21:00',
                    temp: '28.6°',
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Additional Information',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoContainer(
                  icon: Icons.water_drop_rounded,
                  label: 'Humidity',
                  num: '91',
                ),
                AdditionalInfoContainer(
                  icon: Icons.air,
                  label: 'Wind Speed',
                  num: '7.67',
                ),
                AdditionalInfoContainer(
                  icon: Icons.waves,
                  label: 'Pressure',
                  num: '1000',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
