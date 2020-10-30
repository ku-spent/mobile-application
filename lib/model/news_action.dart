import 'package:flutter/material.dart';

class NewsAction {
  static const String like = 'like';
  static const String dislike = 'dislike';
  static const String noneLike = 'noneLike';

  final String likeStatus;

  const NewsAction({@required this.likeStatus});

  set likeStatus(String newLikeStatus) {
    likeStatus = newLikeStatus;
  }
}
