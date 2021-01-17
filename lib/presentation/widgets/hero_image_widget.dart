import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:photo_view/photo_view.dart';

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
          child:
              // Container(
              //   constraints: BoxConstraints(minHeight: 200.0, maxWidth: MediaQuery.of(context).size.width),
              //   // color: Colors.grey.withOpacity(0.5),
              //   // height: 350.0,
              //   // width: MediaQuery.of(context).size.width,
              //   child: PhotoView(
              //     minScale: PhotoViewComputedScale.contained,
              //     maxScale: 1.8,
              //     imageProvider: CachedNetworkImageProvider(url),
              //   ),
              // )
              CachedNetworkImage(
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
