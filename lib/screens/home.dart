import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_blog/screens/detailPage.dart';
import 'package:firebase_blog/screens/inputForm.dart';
import 'package:firebase_blog/widgets/blogTile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future _openShowModelBottomSheet() async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            height: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 30.0,
                            backgroundImage: AssetImage('images/profile.png'),
                          ),
                          SizedBox(
                            width: 24.0,
                          ),
                          Text(
                            "Ishwor Panta",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      RaisedButton.icon(
                        color: Colors.red,
                        textColor: Colors.white,
                        icon: Icon(Icons.mail),
                        onPressed: () =>
                            _launchUrl('mailto:ishworpanta10@gmail.com'),
                        label: Text("Contacts"),
                      )
                    ],
                  ),
                ),

                //divider text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Divider(
                            thickness: 1.7,
                          ),
                        ),
                      ),
                    ),
                    Text("Social Links"),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Divider(
                          thickness: 1.7,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton.icon(
                        color: Colors.white,
                        textColor: Colors.black,
                        icon: Icon(FontAwesomeIcons.github),
                        onPressed: () =>
                            _launchUrl('https://github.com/ishworpanta10'),
                        label: Text("Github"),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      RaisedButton.icon(
                        color: Colors.white,
                        textColor: Colors.black,
                        icon: Icon(
                          FontAwesomeIcons.twitter,
                          color: Colors.lightBlue,
                        ),
                        onPressed: () =>
                            _launchUrl('https://twitter.com/IshworMessi'),
                        label: Text("Twitter"),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      RaisedButton.icon(
                        color: Colors.white,
                        textColor: Colors.black,
                        icon: Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue,
                        ),
                        onPressed: () =>
                            _launchUrl('facebook://facebook.com/ishworpanta10'),
                        label: Text("Facebook"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton.icon(
                  color: Colors.blue,
                  textColor: Colors.white,
                  icon: Icon(
                    Icons.share,
                    color: Colors.yellow[600],
                  ),
                  onPressed: () => Share.share('Share this app'),
                  label: Text(
                    "Share the App",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Version: 1.0.0',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Made with  ❤️  in Nepal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        });
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Can\'t launch $url'),
        ),
      );
      throw "Cannot Launch this URL";
    }
  }

  Future<bool> willpop() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Do you want to exit"),
        content: Text("Exit App"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text('Yes'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willpop,
      child: Scaffold(
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
              icon: Icon(Icons.info),
              onPressed: _openShowModelBottomSheet,
            ),
          ],
          elevation: 0.0,
          titleSpacing: 1.2,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: blogList(),
        ),
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(
                            authorName: snapshots
                                .data.documents[index].data['authorName'],
                            title:
                                snapshots.data.documents[index].data['title'],
                            desc: snapshots.data.documents[index].data['desc'],
                            imgUrl:
                                snapshots.data.documents[index].data['imgUrl'],
                          ),
                        ),
                      );
                    },
                    child: BlogTile(
                      author:
                          snapshots.data.documents[index].data['authorName'],
                      title: snapshots.data.documents[index].data['title'],
                      desc: snapshots.data.documents[index].data['desc'],
                      imgUrl: snapshots.data.documents[index].data['imgUrl'],
                    ),
                  );
                },
              );
          },
        ),
      ),
    );
  }
}
