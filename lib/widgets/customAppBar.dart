import 'package:flutter/material.dart';

AppBar customAppBar = AppBar(
  backgroundColor: Colors.transparent,
  title: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Flutter",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 1.6,
        ),
      ),
      Text(
        "Blog",
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    ],
  ),
  elevation: 0.0,
  titleSpacing: 1.2,
);
