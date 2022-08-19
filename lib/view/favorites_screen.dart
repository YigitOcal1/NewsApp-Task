import 'package:flutter/material.dart';
import 'package:newsapp/components/my_bottom_navigation_bar.dart';
import 'package:newsapp/models/newsarticle_model.dart';
import 'package:newsapp/view/news_screen.dart';
import '../utils/constants.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  List<NewsArticleModel> favoriteList;
  FavoritesScreen(this.favoriteList, {Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() =>
      _FavoritesScreenState(this.favoriteList);
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<NewsArticleModel> favoriteList;

  _FavoritesScreenState(this.favoriteList);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async => false),
      child: Scaffold(
        appBar: appBarFavoritesScreen("Favorites", context),
        body: listViewBuilder(favoriteList),
        bottomNavigationBar: MyBottomNavigationBar(),
      ),
    );
  }
}

PreferredSizeWidget appBarFavoritesScreen(String title, BuildContext context) {
  return AppBar(
    title: Text(
      title,
      style: Constants().appBarTitleTextStyle,
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
  );
}

Widget listViewBuilder(List<NewsArticleModel> favoriteList) {
  return ListView.builder(
      itemCount: favoriteList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                  builder: (context) => DetailsScreen(favoriteList[index]))),
          child: Card(
            child: ListTile(
              focusColor: Colors.blue,
              title: Text(favoriteList[index].title.toString()),
              subtitle: Text(favoriteList[index].description.toString()),
              trailing: ClipRRect(
                child: Image.network(
                  favoriteList[index].urlToImage.toString(),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Constants().loadingProcess;
                  },
                ),
              ),
            ),
          ),
        );
      });
}
