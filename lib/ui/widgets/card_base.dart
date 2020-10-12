import 'package:flutter/material.dart';
import 'package:spent/model/news.dart';
import 'package:spent/ui/pages/webview.dart';
import 'package:timeago/timeago.dart' as timeago;

class CardBase extends StatelessWidget {
  const CardBase({Key key, @required this.news}) : super(key: key);

  final News news;

  void _goToLink(BuildContext context) {
    print('open link');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebViewPage(
                  news: news,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shadowColor: Theme.of(context).primaryColorLight,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            width: 360,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.crop_square),
                        Text(
                          'Thairath',
                        )
                      ],
                    ),
                    Icon(Icons.bookmark_outline)
                  ],
                ),
                GestureDetector(
                  onTap: () => _goToLink(context),
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              news.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          )),
                      Text(
                        news.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        news.body,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        timeago.format(news.publishDate, locale: 'th'),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Row(children: [
                        Icon(Icons.thumb_up_outlined),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.thumb_down_outlined,
                        )
                      ])
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColorLight.withOpacity(.08),
            blurRadius: 16.0,
          ),
        ],
      ),
    );
  }
}
