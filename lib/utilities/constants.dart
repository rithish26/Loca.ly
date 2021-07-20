 import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 80.0,
);

const kMessageTextStyle = TextStyle(
  color:Colors.white,
  fontSize: 40.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,

);

const kConditionTextStyle = TextStyle(
  fontSize: 60.0,
);
const ktextfeildinputdecoration=InputDecoration(
    filled: true,
    fillColor:Colors.white,
    icon: Icon(Icons.location_city,color: Colors.white),
    hintText: 'Enter City Name',
    hintStyle: TextStyle(
      color: Colors.grey,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide.none,
    )
);