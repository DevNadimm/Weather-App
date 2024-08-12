import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApiService {
  final String location = 'Chittagong';
  final String apiKey = '073e067ecb7de3ac02d3614cca930816';

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
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
}
