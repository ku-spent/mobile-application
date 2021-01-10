import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spent/domain/model/news_source.dart';

class SourceIcon extends StatelessWidget {
  final String source;
  final double width;
  final double height;

  const SourceIcon({Key key, @required this.source, this.width = 32.0, this.height = 32.0}) : super(key: key);

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
