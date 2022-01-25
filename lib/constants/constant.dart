import 'package:flutter/material.dart';

const weatherModeStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.bold,
);

const dateStyle = TextStyle(
  color: Color(0xFFA5A6AD),
  fontFamily: 'OpenSans',
  fontSize: 25.0,
);

const cityNameStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.orangeAccent,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.orangeAccent,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Ubuntu',
);
