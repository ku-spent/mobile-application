import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  void _socialSignIn() async {
    try {
      bool res = await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
      print("Social Sign In Success = " + res.toString());
    } on AuthError catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // void onPressedSignin() {
    //   Navigator.push(context, CupertinoPageRoute(builder: (context) => SigninWebviewPage()));
    // }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: _socialSignIn,
            ),
          ],
        ),
      ),
    );
  }
}
