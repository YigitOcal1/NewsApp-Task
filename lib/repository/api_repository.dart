import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/newsarticle_model.dart';
import 'package:newsapp/utils/constants.dart';
import 'package:dio/dio.dart';
import 'service_constants.dart';

class ApiRepository {
  final Dio _dio = Dio();

  Future<List<NewsArticleModel>?> getArticleByKeywordSearch(String? keyWord,
      int? pageKey, List<NewsArticleModel> newsArticleModelsList) async {
    var url =
        "${ServiceConstants.apiUrl}$keyWord&page=$pageKey&apiKey=${ServiceConstants.apiKey}";

    final Response response = await _dio.get(url);
    try {
      if (response.statusCode == 200) {
        for (var index in (response.data["articles"] as List)) {
          newsArticleModelsList.add(NewsArticleModel.fromJson(index));
        }

        return newsArticleModelsList;
      }
    } on DioError catch (e) {
      print("Error: " + e.error.toString());
    }
  }
}
