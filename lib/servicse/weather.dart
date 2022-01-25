import 'package:flutter/cupertino.dart';

import 'networking.dart';
import 'location.dart';

const apiKey = '4f9d71541c37855966dbc2d9b1bd0941';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Image getWeatherImage(int condition, DateTime sunRise, DateTime sunSet) {
    var now = DateTime.now();
    String isDay = 'Night';
    if (now.isAfter(sunRise) && now.isBefore(sunSet)) isDay = 'Day';
    if (condition < 300) {
      return Image.asset(
        'images/$isDay\_Storm.png',
      );
    } else if (condition < 400) {
      return Image.asset('images/$isDay\_Rain.png');
    } else if (condition < 600) {
      return Image.asset('images/$isDay\_Rain.png');
    } else if (condition < 700) {
      return Image.asset('images/$isDay\_Snow.png');
    } else if (condition < 800) {
      return Image.asset('images/$isDay\_Wind.png');
    } else if (condition == 800) {
      if (isDay == 'Night') {
        return Image.asset('images/$isDay\_Moon.png');
      } else
        return Image.asset('images/$isDay\_Sun.png');
    } else {
      return Image.asset('images/$isDay\_Clouds.png');
    }
  }

  bool isDay(DateTime sunRise, DateTime sunSet) {
    var now = DateTime.now();
    print(sunSet);
    print(sunRise);
    print(now);
    if (now.isAfter(sunRise) && now.isBefore(sunSet)) return true;
    return false;
  }
}
