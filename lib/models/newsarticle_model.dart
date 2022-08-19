import 'dart:convert';
import 'package:newsapp/models/source_model.dart';
import 'package:newsapp/utils/constants.dart';

class NewsArticleModel {
  SourceModel? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  bool isAddedFavorite = false;

  NewsArticleModel(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
      required this.isAddedFavorite});

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
        source: SourceModel.fromJson(json['source'] as Map<String, dynamic>),
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'] ?? "",
        urlToImage: json['urlToImage'] ?? Constants.imagePlaceHolder,
        publishedAt: json['publishedAt'],
        content: json['content'],
        isAddedFavorite: false);
  }
}
