import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_auth_plugin_interface/amplify_auth_plugin_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/amplifyconfiguration.dart';
import 'package:spent/presentation/app_screen.dart';
import 'package:spent/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:spent/presentation/pages/welcome_page.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  bool _amplifyConfigured = false;
  Amplify amplifyInstance = Amplify();

  void _configureAmplify() async {
    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    amplifyInstance.addPlugin(authPlugins: [authPlugin]);

    // Once Plugins are added, configure Amplify
    await amplifyInstance.configure(amplifyconfig);
    print((await Amplify.Auth.fetchAuthSession()).isSignedIn);
    try {
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _configureAmplify();
    BlocProvider.of<AuthenticationBloc>(context).add(InitialUser());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animationController.forward();
  }

  Widget _buildLogo() {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/logo.png',
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return AppScreen();
        } else if (state is AuthenticationUnAuthenticated) {
          return WelcomePage();
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buildLogo()],
              ),
            ),
          );
        }
      },
    );
  }
}
