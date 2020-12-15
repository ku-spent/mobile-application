import 'package:flutter/material.dart';

class RetryError extends StatelessWidget {
  final Function callback;

  const RetryError({Key key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Something went wrong!')),
          RaisedButton(
            onPressed: callback,
            child: Text('Retry'),
          )
        ],
      ),
    );
  }
}
