import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class HeroPhotoViewPage extends StatelessWidget {
  final ImageProvider imageProvider;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final String tag;

  const HeroPhotoViewPage({
    @required this.tag,
    @required this.imageProvider,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  @override
  Widget build(BuildContext context) {
    return
        // Dismissible(
        //   direction: DismissDirection.vertical,
        //   key: Key(tag),
        //   onDismissed: (_) => ExtendedNavigator.of(context).pop(),
        //   child:
        Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoViewGestureDetectorScope(
        axis: Axis.vertical,
        child: PhotoView(
          imageProvider: imageProvider,
          backgroundDecoration: backgroundDecoration,
          minScale: PhotoViewComputedScale.contained,
          maxScale: 1.3,
          heroAttributes: PhotoViewHeroAttributes(tag: tag),
        ),
      ),
      // ),
    );
  }
}
