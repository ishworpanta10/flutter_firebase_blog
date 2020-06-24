import 'package:firebase_blog/screens/detailPage.dart';
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
      theme: ThemeData.dark(),
      initialRoute: HomePage.routeName,
      routes: {
        InputForm.routeName: (_) => InputForm(),
        HomePage.routeName: (_) => HomePage(),
        DetailPage.routeName: (_) => DetailPage(),
      },
    );
  }
}
