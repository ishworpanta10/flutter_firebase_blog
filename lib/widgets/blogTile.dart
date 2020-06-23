import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogTile extends StatelessWidget {
  final String title, desc, imgUrl, author;

  BlogTile(
      {@required this.title,
      @required this.desc,
      @required this.imgUrl,
      @required this.author});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: CachedNetworkImage(
                height: 140,
                imageUrl: imgUrl,
                fit: BoxFit.cover,
                width: width,
              ),
            ),
            Container(
              height: 140.0,
              decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 2.0,
              ),
              width: width,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Text(
                  //   desc,
                  //   style: TextStyle(
                  //     fontSize: 14.0,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 5.0,
                  // ),
                  Text("Author : " + author),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
