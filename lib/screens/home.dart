import 'package:cached_network_image/cached_network_image.dart';
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

  QuerySnapshot blogSnapshots;

  @override
  void initState() {
    super.initState();
    _firebaseHelper.getData().then(
      (result) {
        blogSnapshots = result;
      },
    );
  }

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
        child: blogList(),
      ),
    );
  }

  Widget blogList() {
    return Container(
      child: blogSnapshots == null
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: <Widget>[
                ListView.builder(
                  itemCount: blogSnapshots.documents.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    return BlogTile(
                      author: blogSnapshots.documents[index].data['authorName'],
                      title: blogSnapshots.documents[index].data['title'],
                      desc: blogSnapshots.documents[index].data['desc'],   
                      imgUrl: blogSnapshots.documents[index].data['imgUrl'],
                    );
                    // return ListTile(
                    //   leading: Container(
                    //     height: 40.0,
                    //     width: 50.0,
                    //     child: ClipRRect(
                    //       borderRadius: BorderRadius.circular(10.0),
                    //       child: CachedNetworkImage(
                    //           fit: BoxFit.cover,
                    //           imageUrl: blogSnapshots
                    //               .documents[index].data['imgUrl']),
                    //     ),
                    //   ),
                    //   title: Text(blogSnapshots.documents[index].data['title']),
                    //   subtitle: Text(
                    //     'Author : ' +
                    //         blogSnapshots.documents[index].data['authorName'],
                    //   ),
                    //   isThreeLine: true,
                    // );
                  },
                )
              ],
            ),
    );
  }
}
