import 'package:firebase_blog/screens/home.dart';
import 'package:firebase_blog/screens/inputForm.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        // primaryColor: Colors.black,
        buttonTheme: ButtonThemeData(
          minWidth: 40.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        InputForm.routeName: (_) => InputForm(),
        HomePage.routeName: (_) => HomePage(),
      },
    );
  }
}
