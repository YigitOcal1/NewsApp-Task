import 'package:flutter/material.dart';
import 'package:newsapp/models/newsarticle_model.dart';
import 'package:newsapp/repository/api_repository.dart';


class ArticleViewmodel extends ChangeNotifier {
  ApiRepository apiRepository = ApiRepository();

  List<NewsArticleModel> articleModels = [];
  String? searchWord = "";

  Future<List<NewsArticleModel>?> getNewsArticleList(String? keyWord,
      int? pageKey, List<NewsArticleModel> newsArticleModelsList) async {
    searchWord = keyWord;
    await apiRepository.getArticleByKeywordSearch(
        searchWord, pageKey, newsArticleModelsList);
  }
}
