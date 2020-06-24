import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_blog/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class DetailPage extends StatelessWidget {
  final String authorName, title, desc, imgUrl;
  static const String routeName = 'detailPage';

  final int likeCount = 0;

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
        elevation: 0.0,
        titleSpacing: 1.2,
      ),
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
            // Container(
            //   alignment: Alignment.bottomCenter,
            //   child: Icon(
            //     Icons.add_a_photo,
            //     color: Colors.red,
            //   ),
            // ),
            LikeButton(
              size: 20.0,
              likeCount: likeCount,
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.deepOrange : Colors.grey,
                  size: 20.0,
                );
              },
              // countBuilder: (int count, bool isLiked, String text) {
              //   var color = isLiked ? Colors.pinkAccent : Colors.grey;
              //   Widget result;
              //   if (count == 0) {
              //     result = Text(
              //       'Love',
              //       style: TextStyle(color: color),
              //     );
              //   } else {
              //     result = Text(
              //       count >= 100
              //           ? (count / 1000.0).toStringAsFixed(1) + 'k'
              //           : text,
              //       style: TextStyle(color: color),
              //     );
              //   }
              //   return result;
              // },
              likeCountAnimationType: likeCount < 1000
                  ? LikeCountAnimationType.part
                  : LikeCountAnimationType.none,
              likeCountPadding: EdgeInsets.only(left: 15.0),
              onTap: onLikeButtonTapped,
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
                  end: Alignment(0.8, 0.0),
                  colors: [Colors.orange, Colors.blueAccent],
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 22.0, color: Colors.white),
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
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
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

Future<bool> onLikeButtonTapped(bool isLiked) async {
  return !isLiked;
}
