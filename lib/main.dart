import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Weather {
  final String city;
  final int temperature;
  final String condition;
  final int humidity;
  final double windSpeed;

  Weather({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['city'],
      temperature: json['temperature'],
      condition: json['condition'],
      humidity: json['humidity'],
      windSpeed: json['windSpeed'].toDouble(),
    );
  }
}

class MyApp extends StatelessWidget {
  final String jsonString = '[{"city":"New York","temperature":20,"condition":"Clear","humidity":60,"windSpeed":5.5},{"city":"Los Angeles","temperature":25,"condition":"Sunny","humidity":50,"windSpeed":6.8},{"city":"London","temperature":15,"condition":"Partly Cloudy","humidity":70,"windSpeed":4.2},{"city":"Tokyo","temperature":28,"condition":"Rainy","humidity":75,"windSpeed":8.0},{"city":"Sydney","temperature":22,"condition":"Cloudy","humidity":55,"windSpeed":7.3}]';

  const MyApp({super.key});

  List<Weather> _parseJson() {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Weather>((json) => Weather.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Weather> weatherData = _parseJson();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Weather Info App',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
          itemCount: weatherData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(weatherData[index].city),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Temperature: ${weatherData[index].temperature}°C'),
                  Text('Condition: ${weatherData[index].condition}'),
                  Text('Humidity: ${weatherData[index].humidity}%'),
                  Text('Wind Speed: ${weatherData[index].windSpeed} m/s'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
