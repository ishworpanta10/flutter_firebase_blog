import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_blog/class/firebaseHelper.dart';
import 'package:firebase_blog/screens/inputForm.dart';
import 'package:firebase_blog/widgets/blogTile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseHelper _firebaseHelper = FirebaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              })
        ],
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
        child: blogList(),
      ),
    );
  }

  Widget blogList() {
    return GestureDetector(
      child: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection('blog').snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return ListView.builder(
                itemCount: snapshots.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return BlogTile(
                    author: snapshots.data.documents[index].data['authorName'],
                    title: snapshots.data.documents[index].data['title'],
                    desc: snapshots.data.documents[index].data['desc'],
                    imgUrl: snapshots.data.documents[index].data['imgUrl'],
                  );
                },
              );
          },
        ),
      ),
    );
  }
}
