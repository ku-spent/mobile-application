import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:spent/presentation/pages/signin_webview_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onPressedSignin() {
      Navigator.push(context, CupertinoPageRoute(builder: (context) => SigninWebviewPage()));
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: onPressedSignin,
            ),
          ],
        ),
      ),
    );
  }
}
