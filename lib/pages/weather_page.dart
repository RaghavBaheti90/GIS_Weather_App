import 'package:flutter/material.dart';
import 'package:gis_weather_app/data/api_key.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:weather/weather.dart';

class weather_page extends StatefulWidget {
  String city;
  weather_page({super.key, required this.city});

  @override
  State<weather_page> createState() => _weather_pageState();
}

class _weather_pageState extends State<weather_page> {
  final WeatherFactory _wf = WeatherFactory(API_KEY);

  Weather? _weather;

  @override
  //Fetching Weater Data From Open Weather API
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("${widget.city}").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          // PULL TO REFRESH
          child: LiquidPullToRefresh(
              color: Colors.blue.shade400,
              height: 150,
              animSpeedFactor: 2,
              onRefresh: _handleRefresh,
              child: ListView(children: [_UI()]))),
    );
  }

  Widget _UI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(), //Fetching Location Data From Open Weather API
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
          ),
          _dateTimeInfo(), //Fetching Date & Time Info From Open Weather API
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          _weatherIcon(), // Fetching Weater Icon From Open Weather API
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _currenttemp(), //Fetching Temp Data From Open Weather API
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _exinfo(), //Fetching Extra Info From Open Weather API
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(fontSize: 38),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Displaying the current day of the week
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            // Displaying the current date in day.month.year format
            Text(
              "  ${DateFormat("d.m.y").format(now)}",
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        )
      ],
    );
  }

  // Widget to display the weather icon
  Widget _weatherIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        // Container to hold the weather icon
        Container(
          // Setting the height of the container to 20% of the screen height
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
              // DecorationImage to display the weather icon from a network source
              image: DecorationImage(
                  image: NetworkImage(
                      "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"))),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(color: Colors.black, fontSize: 20),
        )
      ],
    );
  }

  Widget _currenttemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
      style: const TextStyle(
          color: Colors.black, fontSize: 70, fontWeight: FontWeight.w500),
    );
  }

  Widget _exinfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
          color: Colors.blue.shade400, borderRadius: BorderRadius.circular(25)),
      padding: EdgeInsets.all(9.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Max Temp: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}°C",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Min Temp: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}°C",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Wind Speed: ${_weather?.windSpeed?.toStringAsFixed(0)} km/s",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
