import 'package:flutter/material.dart';
import 'package:newsapp/models/newsarticle_model.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:newsapp/view/webview_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/constants.dart';

List<NewsArticleModel> favoriteArticleList = [];

class DetailsScreen extends StatefulWidget {
  NewsArticleModel articleModels;

  DetailsScreen(this.articleModels, {Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState(articleModels);
}

class _DetailsScreenState extends State<DetailsScreen> {
  NewsArticleModel articleNewsDetails;
  _DetailsScreenState(this.articleNewsDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: detailsScreenAppBar(context, articleNewsDetails),
      ),
      backgroundColor: Colors.white,
      body: detailsScreenBody(context, articleNewsDetails),
    );
  }
}

PreferredSizeWidget detailsScreenAppBar(
    BuildContext context, NewsArticleModel articleNewsDetails) {
  return PreferredSize(
    preferredSize: Size.fromHeight(1.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Constants().backIcon),
        Spacer(flex: 10),
        IconButton(
          onPressed: () {
            FlutterShare.share(
                title: articleNewsDetails.url.toString(),
                text: "You can share this news: ",
                linkUrl: articleNewsDetails.url.toString());
          },
          icon: Icon(
            Icons.share,
            color: Colors.black,
          ),
        ),
        IconButton(
          autofocus: true,
          onPressed: () {
            if (articleNewsDetails.isAddedFavorite != true) {
              articleNewsDetails.isAddedFavorite = true;
              favoriteArticleList.add(articleNewsDetails);
              Fluttertoast.showToast(
                msg: "You have successfully added this news to your favorites.",
              );
            } else {
              Fluttertoast.showToast(
                msg: "You have already added this news to your favorites.",
              );
            }
          },
          icon: Icon(
            Icons.favorite,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

Widget detailsScreenBody(
    BuildContext context, NewsArticleModel articleNewsDetails) {
  return SafeArea(
    child: Stack(
      children: [
        Column(
          children: [
            ClipRRect(
              child: Image.network(
                articleNewsDetails.urlToImage.toString(),
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  print("Network Image Error: ${exception.toString()}");
                  return Image.network(Constants.imagePlaceHolder);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                articleNewsDetails.title.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            // TO DO: row overflow problem uzun textlerde
            Wrap(
              //spacing: 32,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.border_color_rounded,
                      color: Colors.black,
                    ),
                    Text(
                      "By: " + articleNewsDetails.author.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Icon(
                      Icons.date_range,
                      color: Colors.black,
                    ),
                    Text(
                      "Date: " +
                          articleNewsDetails.publishedAt
                              .toString()
                              .substring(0, 10),
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                articleNewsDetails.content.toString(),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        newsSourceButton(context, articleNewsDetails),
      ],
    ),
  );
}

Widget newsSourceButton(
    BuildContext context, NewsArticleModel articleNewsDetails) {
  return Positioned(
    bottom: 20,
    child: TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  WebViewScreen((articleNewsDetails.url.toString()))),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 83,
        ),
        child: Container(
          height: 40,
          width: 220,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black)),
          child: Center(
            child: Text(
              "News Source",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
