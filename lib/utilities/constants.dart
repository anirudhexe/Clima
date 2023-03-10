import 'package:flutter/material.dart';

const kcityTextStyle = TextStyle(
  fontFamily: 'Kanit',
  fontSize: 60.0
);

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 50.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'YeonSung',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
  color: Colors.white
);

const kConditionTextStyle = TextStyle(
  fontSize: 60.0,
);

const ktextFieldDecoration=InputDecoration(
  filled: true,
  fillColor: Colors.black12,
  hintText: 'enter city name',
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);
