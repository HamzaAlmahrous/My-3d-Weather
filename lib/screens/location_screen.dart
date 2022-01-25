import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:my_3d_weather_hm7/screens/search_screen.dart';
import 'package:my_3d_weather_hm7/servicse/weather.dart';
import 'package:intl/intl.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:my_3d_weather_hm7/componants/gardient_text.dart';
import 'package:my_3d_weather_hm7/constants/constant.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late LinearGradient temperatureGradient;
  late int temperature;
  late int sunRise;
  late int sunSet;
  late Image weatherImage;
  late String cityName;
  late String weatherMode;
  late Color bkColor;
  late Color cityNameColor;
  late String date;
  late Color weatherModeColor;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        cityName = 'Error';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      weatherMode = weatherData['weather'][0]['main'];
      cityName = weatherData['name'];
      date = getDate();
      var condition = weatherData['weather'][0]['id'];
      sunRise = weatherData['sys']['sunrise'];
      sunSet = weatherData['sys']['sunset'];

      var ss = DateTime.fromMillisecondsSinceEpoch(sunSet * 1000);
      var sr = DateTime.fromMillisecondsSinceEpoch(sunRise * 1000);
      weatherModeColor =
          weather.isDay(sr, ss) ? Color(0xFFF8943A) : Color(0xFF7C82D1);
      bkColor = weather.isDay(sr, ss) ? Colors.white : Color(0xFF111825);
      cityNameColor = weather.isDay(sr, ss) ? Colors.black : Colors.white;
      temperatureGradient = weather.isDay(sr, ss)
          ? LinearGradient(
              colors: [
                Colors.black,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          : LinearGradient(
              colors: [
                Colors.white,
                Colors.black,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );
      weatherImage = weather.getWeatherImage(condition, sr, ss);
    });
  }

  String getDate() {
    var now = DateTime.now();
    int day = now.day;
    int year = now.year;
    String month = DateFormat.MMMM().format(now);
    return '$month $day, $year';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bkColor,
      bottomNavigationBar: BottomAppBar(
        color: bkColor,
        elevation: 0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: IconButton(
                onPressed: () async {
                  var weatherData = await weather.getLocationWeather();
                  updateUI(weatherData);
                },
                icon: Icon(
                  Icons.home_outlined,
                  size: 30.0,
                  color: Color(0xFFA5A6AD),
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () async {
                  var typedName = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SearchScreen(bkColor);
                      },
                    ),
                  );
                  if (typedName != null) {
                    var weatherData = await weather.getCityWeather(typedName);
                    print(weatherData);
                    updateUI(weatherData);
                  }
                },
                icon: Icon(
                  Icons.location_on_outlined,
                  size: 30.0,
                  color: Color(0xFFA5A6AD),
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border_rounded,
                  size: 30.0,
                  color: Color(0xFFA5A6AD),
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.perm_identity_rounded,
                  size: 30.0,
                  color: Color(0xFFA5A6AD),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                SizedBox(
                  width: 25.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(getDate(), style: dateStyle),
                    Text(
                      cityName,
                      style: cityNameStyle.copyWith(color: cityNameColor),
                    ),
                  ],
                ),
                SizedBox(
                  width: 60.0,
                ),
                Flexible(
                  child: Container(
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 35.0,
                      color: Color(0xFFA5A6AD),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                height: 300,
                width: 300,
                child: SimpleShadow(
                  child: weatherImage,
                  opacity: 0.5, // Default: 0.5
                  color: Colors.grey, // Default: Black
                  offset: Offset(7, 7), // Default: Offset(2, 2)
                  sigma: 100, // Default: 2
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 25.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GradientText('$temperature°',
                        gradient: temperatureGradient),
                    Text(weatherMode,
                        style:
                            weatherModeStyle.copyWith(color: weatherModeColor)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
