import 'package:flutter/material.dart';
import 'package:newsapp/components/my_bottom_navigation_bar.dart';
import 'package:newsapp/models/newsarticle_model.dart';
import 'package:newsapp/utils/constants.dart';
import 'package:newsapp/view/details_screen.dart';
import 'package:newsapp/view_model/article_viewmodel.dart';
import 'package:provider/provider.dart';

int pageKeyCounter = 1;

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  TextEditingController searchTextEditingController = TextEditingController();
  ScrollController? scrollController;
  List<NewsArticleModel> newsArticleModels = [];
  bool isLoading = false;
  bool _hasNextPage = true;
  late Future<List<NewsArticleModel>?> _future;
  @override
  void initState() {
    // TODO: implement initState
    createScrollController();

    super.initState();
  }

  void createScrollController() {
    scrollController = ScrollController();
    scrollController?.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        pageKeyCounter++;
        loadMoreNewsArticle(searchTextEditingController.text, pageKeyCounter);
      }
    });
  }

  Future<void> loadNewsArticle(String searchKeyWord) async {
    final articleViewModel =
        Provider.of<ArticleViewmodel>(context, listen: false);
    pageKeyCounter = 1;

    await articleViewModel.getNewsArticleList(
        searchKeyWord, pageKeyCounter, newsArticleModels);
    setState(() {});
  }

  void loadMoreNewsArticle(String keyword, int pageNumber) async {
    final articleViewModel =
        Provider.of<ArticleViewmodel>(context, listen: false);

    await articleViewModel.getNewsArticleList(
        keyword, pageNumber, newsArticleModels);

    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController?.dispose();
    searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async => false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.white54,
          title: Text(
            'NewsApp',
            style: Constants().appBarTitleTextStyle,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: newsScreenAppBar(),
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 80,
            ),
            getArticleNewsView(pageKeyCounter),
          ],
        ),
        bottomNavigationBar: MyBottomNavigationBar(),
      ),
    );
  }

  PreferredSizeWidget newsScreenAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(30.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Material(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (() {
                    setState(() {
                      newsArticleModels.clear();
                      searchTextEditingController.clear();
                      pageKeyCounter = 1;
                    });
                  }),
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration:
                        InputDecoration.collapsed(hintText: 'Type a text.'),
                    controller: searchTextEditingController,
                    onSubmitted: (value) {
                      loadNewsArticle(value.toLowerCase());
                    },
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    searchTextEditingController.clear();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getArticleNewsView(int pageNumber) {
    return Expanded(
      child: ListView.builder(
          controller: scrollController,
          itemCount: newsArticleModels.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      DetailsScreen(newsArticleModels[index]))),
              child: Card(
                child: ListTile(
                  focusColor: Colors.blue,
                  title: Text(newsArticleModels[index].title.toString()),
                  subtitle:
                      Text(newsArticleModels[index].description.toString()),
                  trailing: SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      child: Image.network(
                        newsArticleModels[index].urlToImage.toString(),
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Constants().loadingProcess;
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          print("Network Image Error: ${exception.toString()}");
                          return Image.network(Constants.imagePlaceHolder);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
