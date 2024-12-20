import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nam_wea/models/weather_model.dart';
import 'package:nam_wea/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('95acf8db60c9e1419ec18b44f80108ff');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherService.getCurrentCity();
    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sun.json'; //default to sunny

    switch (mainCondition.toLowerCase()) {
      case 'cloud':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';

      case 'thunderstorm':
        return 'assets/thunder.json';

      case 'clear':
        return 'assets/sun.json';
      default:
        return 'assets/sun.json';
    }
  }

  //action animations
  String getActionAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/rainy.json'; //default to sunny

    switch (mainCondition.toLowerCase()) {
      case 'cloud':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/rainy.json';

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/umbrella.json';

      case 'thunderstorm':
        return 'assets/rainy.json';

      case 'clear':
        return 'assets/sun.json';
      default:
        return 'assets/umbrella.json';
    }
  }

  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather on start up
    _fetchWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Center(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text("Weathero"),
        )),
        backgroundColor: Colors.grey[500],
      ),
      body: ListView(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome...👋",
                  style: TextStyle(
                      color: Colors.brown[900],
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(
                  height: 50,
                ),

                Icon(Icons.location_city),
                //city name
                Text(_weather?.cityName ?? "Loading city..."),

                //animation
                Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
                //temperature
                Text('${_weather?.temperature.round()}°C'),

                //Animation
                Text(_weather?.mainCondition ?? "Loading..."),

                const SizedBox(height: 40),

                Divider(),
                const SizedBox(height: 30),
                Divider(),
                //action Animations
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child:
                      Lottie.asset(getActionAnimation(_weather?.mainCondition)),
                ),

                //don't forget to...
                Text('Dont Forget to 👆😃')
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
