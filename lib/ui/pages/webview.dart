import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spent/model/news.dart';
import 'package:spent/ui/widgets/webview_bottom.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final News news;

  WebViewPage({Key key, this.news}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _controller;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void _loadUrl() async {
    Future.delayed(const Duration(seconds: 1), () {
      _controller.loadUrl(widget.news.url);
      _loadFinished();
    });
  }

  void _loadFinished() async {
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.url,
            style: TextStyle(fontSize: 14, color: Colors.white)),
        bottom: _isLoaded
            ? null
            : MyLinearProgressIndicator(backgroundColor: Colors.purple[200]),
      ),
      body: Container(
          color: Colors.white,
          child: WebView(
            initialUrl: 'about:blank',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              _loadUrl();
            },
          )),
      bottomNavigationBar: _isLoaded ? WebViewBottom() : null,
    );
  }
}

const double _kMyLinearProgressIndicatorHeight = 6.0;

class MyLinearProgressIndicator extends LinearProgressIndicator
    implements PreferredSizeWidget {
  MyLinearProgressIndicator({
    Key key,
    double value,
    Color backgroundColor,
    Animation<Color> valueColor,
  }) : super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor,
        ) {
    preferredSize = Size(double.infinity, _kMyLinearProgressIndicatorHeight);
  }

  @override
  Size preferredSize;
}
