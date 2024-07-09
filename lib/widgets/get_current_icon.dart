import 'package:flutter/material.dart';

IconData getWeatherIcon(String currentSky) {
  switch (currentSky) {
    case 'Clouds':
      return Icons.cloud;
    case 'Rain':
      return Icons.grain;
    case 'Sunny':
      return Icons.wb_sunny;
    case 'Snow':
      return Icons.ac_unit;
    case 'Thunderstorm':
      return Icons.flash_on;
    case 'Drizzle':
      return Icons.grain;
    case 'Clear':
      return Icons.wb_sunny;
    default:
      return Icons.help;
  }
}