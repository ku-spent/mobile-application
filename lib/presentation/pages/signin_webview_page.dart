import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/core/constants.dart';
import 'package:spent/presentation/bloc/signin/signin_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SigninWebviewPage extends StatefulWidget {
  SigninWebviewPage({Key key}) : super(key: key);

  @override
  _SigninWebviewPageState createState() => _SigninWebviewPageState();
}

class _SigninWebviewPageState extends State<SigninWebviewPage> {
  SigninBloc _signinBloc;
  final Completer<WebViewController> _webViewController = Completer<WebViewController>();

  static const String url = AUTH_ENDPOINT +
      "/authorize?identity_provider=Google&redirect_uri=" +
      "myapp://&response_type=CODE&client_id=" +
      AWS_COGNITO_CLIENT_ID +
      "&scope=email%20openid%20profile%20aws.cognito.signin.user.admin";

  @override
  void initState() {
    super.initState();
    // CookieManager().clearCookies();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _signinBloc = BlocProvider.of<SigninBloc>(context);
    _signinBloc.add(InitialSignin());
  }

  Future<NavigationDecision> shouldOverrideUrlLoading(NavigationRequest request, BuildContext context) async {
    if (request.url.startsWith("myapp://?code=")) {
      String code = request.url.substring("myapp://?code=".length).replaceAll('#', '');
      _signinBloc.add(SignInWithFederatedCognitoAuthCode(authCode: code));
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state is SigninError || state is SigninSuccess) {
          Navigator.pop(context);
        }
      },
      cubit: _signinBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Signin'),
        ),
        body: WebView(
          initialUrl: url,
          userAgent: 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) ' +
              'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController.complete(webViewController);
          },
          navigationDelegate: (request) => shouldOverrideUrlLoading(request, context),
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }
}
