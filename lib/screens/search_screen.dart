import 'package:flutter/material.dart';
import 'package:my_3d_weather_hm7/constants/constant.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen(this.bkColor);
  final Color bkColor;
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String cityName;
  late Color otherColor;
  @override
  void initState() {
    super.initState();
    if (widget.bkColor == Colors.white) {
      otherColor = Colors.black;
    } else {
      otherColor = Color(0xFFA5A6AD);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bkColor,
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration:
                      kTextFieldInputDecoration.copyWith(fillColor: otherColor),
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle.copyWith(color: otherColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
