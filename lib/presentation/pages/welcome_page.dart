import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/presentation/bloc/signin/signin_bloc.dart';
import 'package:spent/presentation/widgets/hex_color.dart';
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
        // backgroundColor: HexColor('004EBF'),
        body: Container(
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //   image: AssetImage(
          //     'assets/images/login-background.jpg',
          //   ),
          //   fit: BoxFit.cover,
          // )),
          child: Center(
              child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Logo(),
                  Text(
                    'SPENT',
                    style: GoogleFonts.kanit(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        textStyle: TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                  Text(
                    'Smart Personalized News Tracking',
                    style: GoogleFonts.kanit(fontSize: 16.0, textStyle: TextStyle(color: Colors.black45)),
                  ),
                  Container(height: 100.0),
                  SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: _socialSignIn,
                    elevation: 1,
                  ),
                ],
              ),
              state is SigninLoading ? Loader() : Container()
            ],
          )),
        ),
      ),
    );
  }
}
