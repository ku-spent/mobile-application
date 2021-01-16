import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';

class HeroImageViewWidget extends StatelessWidget {
  final String tag;
  final String url;

  const HeroImageViewWidget({Key key, @required this.tag, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FullScreenWidget(
      child: Center(
        child: Hero(
          tag: tag,
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => Container(
              color: Colors.black26,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
