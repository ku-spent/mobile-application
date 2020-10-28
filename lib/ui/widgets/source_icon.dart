import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spent/model/news.dart';

class SourceIcon extends StatelessWidget {
  final String source;

  const SourceIcon({Key key, @required this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      child: CachedNetworkImage(
        imageUrl: NewsSource.newsSourceIcon[source],
        placeholder: (context, url) => Container(
          color: Colors.black26,
          width: 20,
          height: 20,
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.black26,
          width: 20,
          height: 20,
        ),
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
