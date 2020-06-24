import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_blog/widgets/customAppBar.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String authorName, title, desc, imgUrl;
  static const String routeName = 'detailPage';

  const DetailPage(
      {@required this.authorName,
      @required this.title,
      @required this.desc,
      @required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: customAppBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              height: height * 0.4,
              width: width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: Hero(
                  tag: 'img' + imgUrl.toString(),
                  child: CachedNetworkImage(
                    imageUrl: imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: width,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(
                      0.8, 0.0), 
                  colors: [
                    Colors.orange,
                    Colors.blueAccent
                  ], 
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 22.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10.0,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    desc,
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
