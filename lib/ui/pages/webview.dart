import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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
  bool _isLoaded = false;
  bool _isClickBack = false;

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Future<String> _getUrl() async {
    return Future.delayed(
        const Duration(milliseconds: 400), () => widget.news.url);
  }

  void _loadFinished(controller, String url) async {
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        _isLoaded = true;
      });
    });
  }

  Future<bool> _onWillPop() async {
    setState(() {
      _isClickBack = true;
    });
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.news.url,
                style: TextStyle(fontSize: 14, color: Colors.white)),
            bottom: _isLoaded
                ? null
                : MyLinearProgressIndicator(
                    backgroundColor: Colors.purple[200]),
          ),
          body: Container(
              color: Colors.white,
              child: FutureBuilder(
                future: _getUrl(),
                builder: (BuildContext context, AsyncSnapshot snapshot) =>
                    AnimatedSwitcher(
                        duration: const Duration(milliseconds: 450),
                        child: snapshot.hasData && !_isClickBack
                            ? InAppWebView(
                                initialUrl: snapshot.data,
                                onLoadStop: _loadFinished,
                                initialOptions: InAppWebViewGroupOptions(
                                    crossPlatform: InAppWebViewOptions(
                                        javaScriptEnabled: false,
                                        transparentBackground: true)),
                              )
                            : Container(
                                color: Colors.white,
                              )),
              )),
          bottomNavigationBar: WebViewBottom(),
        ),
        onWillPop: _onWillPop);
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
