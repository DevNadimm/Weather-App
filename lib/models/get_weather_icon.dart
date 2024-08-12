import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

IconData getWeatherIcon(String weatherCondition) {
  const weatherIcons = {
    'Thunderstorm': WeatherIcons.thunderstorm,
    'Drizzle': WeatherIcons.sprinkle,
    'Rain': WeatherIcons.rain,
    'Snow': WeatherIcons.snow,
    'Clouds': WeatherIcons.cloudy,
    'Fog': WeatherIcons.fog,
    'Clear': WeatherIcons.day_sunny,
    'Partly Cloudy': WeatherIcons.day_cloudy,
  };

  const weatherCodeMapping = {
    '2': 'Thunderstorm',
    '3': 'Drizzle',
    '5': 'Rain',
    '6': 'Snow',
    '7': 'Fog',
    '8': 'Clouds',
  };

  String condition;

  if (weatherCondition.length == 3 &&
      weatherCodeMapping.containsKey(weatherCondition[0])) {
    condition = weatherCodeMapping[weatherCondition[0]] ?? 'Clear';
  } else {
    condition = weatherCondition;
  }

  return weatherIcons[condition] ?? WeatherIcons.na;
}
