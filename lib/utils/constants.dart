import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static const String imagePlaceHolder =
      "https://www.industry.gov.au/sites/default/files/August%202018/image/news-placeholder-738.png";
  static String? searchKeyWord = "";

  TextStyle appBarTitleTextStyle = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22);

  Padding loadingProcess = const Padding(
    padding: EdgeInsets.all(12.0),
    child: CircularProgressIndicator(),
  );

  Icon backIcon = const Icon(
    Icons.arrow_back,
    color: Colors.black,
  );
}
