import 'package:flutter/material.dart';
import 'package:gis_weather_app/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.black,
            buttonTheme: const ButtonThemeData(buttonColor: Colors.black)),
        debugShowCheckedModeBanner: false,
        home: const Homescreen());
  }
}
