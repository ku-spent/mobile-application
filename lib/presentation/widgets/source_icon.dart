import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spent/domain/model/news_source.dart';

class SourceIcon extends StatelessWidget {
  final String source;
  final double width = 32;
  final double height = 32;

  const SourceIcon({Key key, @required this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: NewsSource.newsSourceIcon[source],
        placeholder: (context, url) => Container(
          color: Colors.black26,
          width: width,
          height: height,
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.black26,
          width: width,
          height: height,
        ),
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
