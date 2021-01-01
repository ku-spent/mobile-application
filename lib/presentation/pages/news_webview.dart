// import 'package:flutter/material.dart';
// import 'package:spent/domain/model/News.dart';
// import 'package:spent/presentation/widgets/webview_bottom.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class NewsWebview extends StatefulWidget {
//   final News news;

//   NewsWebview({Key key, this.news}) : super(key: key);

//   @override
//   _NewsWebviewState createState() => _NewsWebviewState();
// }

// class _NewsWebviewState extends State<NewsWebview> {
//   bool _isLoaded = false;

//   Future<String> _getUrl() async {
//     return Future.delayed(const Duration(milliseconds: 350), () => widget.news.url);
//   }

//   void _loadFinished(String url) async {
//     setState(() {
//       _isLoaded = true;
//     });
//   }

//   PreferredSize _createProgressIndicator() => PreferredSize(
//         preferredSize: Size(double.infinity, 6.0),
//         child: SizedBox(
//           height: 6.0,
//           child: LinearProgressIndicator(backgroundColor: Colors.grey[200]),
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.news.url, style: TextStyle(fontSize: 14, color: Colors.white)),
//         bottom: _isLoaded ? null : _createProgressIndicator(),
//       ),
//       body: Container(
//           color: Colors.white,
//           child: FutureBuilder(
//             future: _getUrl(),
//             builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot.hasData
//                 ? Stack(
//                     children: [
//                       WebView(
//                         initialUrl: widget.news.url,
//                         onPageFinished: _loadFinished,
//                         userAgent: 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) ' +
//                             'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36',
//                         javascriptMode: JavascriptMode.disabled,
//                         gestureNavigationEnabled: true,
//                       ),
//                       IgnorePointer(
//                           ignoring: true,
//                           child: AnimatedOpacity(
//                             opacity: _isLoaded ? 0 : 1,
//                             duration: const Duration(milliseconds: 200),
//                             child: Container(
//                               width: double.infinity,
//                               height: double.infinity,
//                               color: _isLoaded ? Colors.white : Colors.white,
//                             ),
//                           ))
//                     ],
//                   )
//                 : Container(width: double.infinity, height: double.infinity, color: Colors.white),
//           )),
//       bottomNavigationBar: WebViewBottom(
//         news: widget.news,
//       ),
//     );
//   }
// }
