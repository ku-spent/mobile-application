import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spent/presentation/pages/hero_photo_view_page.dart';

class HeroImageViewWidget extends StatelessWidget {
  final String tag;
  final String url;

  const HeroImageViewWidget({Key key, @required this.tag, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => HeroPhotoViewPage(
              tag: tag,
              imageProvider: CachedNetworkImageProvider(url),
            ),
          ),
        );
      },
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
    );
  }
}
