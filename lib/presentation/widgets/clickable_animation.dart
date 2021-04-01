import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class ClickableAnimation extends StatelessWidget {
  final IconData inActive;
  final IconData active;
  final Color activeColor;
  final bool isActive;
  final bool toggleStatus;
  final void Function() onPressed;

  const ClickableAnimation({
    Key key,
    @required this.inActive,
    @required this.active,
    this.activeColor,
    this.isActive = false,
    this.onPressed,
    this.toggleStatus = true,
  }) : super(key: key);

  Future<bool> onTap(bool isLiked) async {
    onPressed();
    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    final _activeColor = activeColor != null ? activeColor : Theme.of(context).primaryColor;
    return LikeButton(
      padding: const EdgeInsets.all(6.0),
      onTap: onTap,
      isLiked: isActive,
      likeBuilder: (isLiked) {
        return Icon(
          isLiked ? active : inActive,
          color: isLiked && toggleStatus ? _activeColor : Colors.grey,
        );
      },
    );
  }
}
