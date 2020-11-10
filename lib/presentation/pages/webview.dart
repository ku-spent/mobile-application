import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:spent/domain/model/news.dart';
import 'package:spent/presentation/widgets/webview_bottom.dart';

class WebViewPage extends StatefulWidget {
  final News news;

  WebViewPage({Key key, this.news}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  Future<String> _getUrl() async {
    return Future.delayed(
        const Duration(milliseconds: 400), () => widget.news.url);
  }

  void _loadFinished(controller, String url) async {
    Future.delayed(const Duration(milliseconds: 300), () {
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
          child: FutureBuilder(
            future: _getUrl(),
            builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot
                    .hasData
                ? Stack(
                    children: [
                      InAppWebView(
                        initialUrl: snapshot.data,
                        onLoadStop: _loadFinished,
                        initialOptions: InAppWebViewGroupOptions(
                            crossPlatform:
                                InAppWebViewOptions(javaScriptEnabled: false)),
                      ),
                      IgnorePointer(
                          ignoring: true,
                          child: AnimatedOpacity(
                            opacity: _isLoaded ? 0 : 1,
                            duration: const Duration(milliseconds: 900),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  )
                : Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white),
          )),
      bottomNavigationBar: WebViewBottom(
        news: widget.news,
      ),
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
