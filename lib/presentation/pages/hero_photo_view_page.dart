import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_swipe.dart';

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

  static PhotoViewScaleState scaleStateCycle(PhotoViewScaleState actual) {
    switch (actual) {
      case PhotoViewScaleState.initial:
        return PhotoViewScaleState.covering;
      case PhotoViewScaleState.covering:
        return PhotoViewScaleState.initial;
      case PhotoViewScaleState.zoomedIn:
      case PhotoViewScaleState.zoomedOut:
        return PhotoViewScaleState.initial;
      default:
        return PhotoViewScaleState.initial;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PhotoViewSwipe(
        scaleStateCycle: scaleStateCycle,
        imageProvider: imageProvider,
        backgroundDecoration: backgroundDecoration,
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered,
        heroAttributes: PhotoViewHeroAttributes(tag: tag),
      ),
    );
  }
}
