import 'package:flutter/material.dart';
import 'package:newsapp/utils/constants.dart';
import 'package:newsapp/view_model/article_viewmodel.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  String webViewUrl;
  WebViewScreen(this.webViewUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWebView("News Source", context),
      body: WebView(
        initialUrl: webViewUrl,
      ),
    );
  }
}

PreferredSizeWidget appBarWebView(String title, BuildContext context) {
  return AppBar(
    title: Text(title.toString(), style: Constants().appBarTitleTextStyle),
    centerTitle: true,
    backgroundColor: Colors.white,
    leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Constants().backIcon),
  );
}
