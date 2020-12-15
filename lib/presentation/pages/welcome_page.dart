import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:spent/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:spent/presentation/bloc/signin/signin_bloc.dart';
import 'package:spent/presentation/widgets/loader.dart';
import 'package:spent/presentation/widgets/logo.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  SigninBloc _signinBloc;

  @override
  void initState() {
    super.initState();
    _signinBloc = BlocProvider.of<SigninBloc>(context);
    _signinBloc.add(InitialSignin());
  }

  @override
  Widget build(BuildContext context) {
    void _socialSignIn() async {
      _signinBloc.add(SignInWithHostedUi());
    }

    return BlocBuilder<SigninBloc, SigninState>(
      builder: (context, state) => Scaffold(
        body: Center(
            child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Logo(),
                Container(height: 100.0),
                SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: _socialSignIn,
                ),
              ],
            ),
            state is SigninLoading ? Loader() : Container()
          ],
        )),
      ),
    );
  }
}
