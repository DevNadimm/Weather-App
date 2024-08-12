import 'package:flutter/material.dart';

class WeatherForecastContainer extends StatelessWidget {
  const WeatherForecastContainer(
      {super.key, required this.icon, required this.time, required this.temp});

  final IconData icon;
  final String temp;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 125,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 8),
          Icon(
            icon,
            size: 26,
          ),
          const SizedBox(height: 8),
          Text(
            temp,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
