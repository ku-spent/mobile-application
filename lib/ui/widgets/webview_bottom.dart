import 'package:flutter/material.dart';

class WebViewBottom extends StatelessWidget {
  const WebViewBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: 1, color: Theme.of(context).dividerColor))),
        height: 48.0,
        child: Padding(
          padding: EdgeInsets.only(left: 32, right: 32),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.thumb_up_alt_outlined),
                onPressed: () => {},
                color: Theme.of(context).hintColor,
              ),
              Container(
                width: 28,
              ),
              IconButton(
                icon: Icon(Icons.thumb_down_alt_outlined),
                onPressed: () => {},
                color: Theme.of(context).hintColor,
              ),
              Container(
                width: 28,
              ),
              IconButton(
                icon: Icon(Icons.bookmark_outline),
                onPressed: () => {},
                color: Theme.of(context).hintColor,
              ),
              Container(
                width: 28,
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () => {},
                color: Theme.of(context).hintColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
