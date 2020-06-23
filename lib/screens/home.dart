import 'package:firebase_blog/screens/inputform.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String routeName = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            )
          ],
        ),
        elevation: 0.0,
        titleSpacing: 1.2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.only(
          bottom: 12.0,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, InputForm.routeName);
          },
          child: Icon(Icons.add),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
