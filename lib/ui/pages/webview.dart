import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spent/model/news.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final News news;

  WebViewPage({Key key, this.news}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void _loadUrl() async {
    Future.delayed(const Duration(milliseconds: 1000), () {
      print(123);
      _controller.loadUrl(widget.news.url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.url,
            style: TextStyle(fontSize: 14, color: Colors.white)),
      ),
      body: Container(
        color: Colors.white,
        child: Container(),
      ),
      // child: WebView(
      //   initialUrl: 'about:blank',
      //   javascriptMode: JavascriptMode.unrestricted,
      //   onWebViewCreated: (WebViewController webViewController) {
      //     _controller = webViewController;
      //     _loadUrl();
      //     // _controller.loadUrl(widget.news.url);
      //   },
      // )),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      width: 1, color: Theme.of(context).dividerColor))),
          height: 56.0,
          child: Padding(
            padding: EdgeInsets.only(left: 32, right: 32),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 28.0,
                  icon: Icon(Icons.thumb_up_alt_outlined),
                  onPressed: () => {},
                  color: Theme.of(context).hintColor,
                ),
                Container(
                  width: 28,
                ),
                IconButton(
                  iconSize: 28.0,
                  icon: Icon(Icons.thumb_down_alt_outlined),
                  onPressed: () => {},
                  color: Theme.of(context).hintColor,
                ),
                Container(
                  width: 28,
                ),
                IconButton(
                  iconSize: 28.0,
                  icon: Icon(Icons.bookmark_outline),
                  onPressed: () => {},
                  color: Theme.of(context).hintColor,
                ),
                Container(
                  width: 28,
                ),
                IconButton(
                  iconSize: 28.0,
                  icon: Icon(Icons.share),
                  onPressed: () => {},
                  color: Theme.of(context).hintColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
