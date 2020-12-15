import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/core/constants.dart';
import 'package:spent/presentation/app_screen.dart';
import 'package:spent/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:spent/presentation/pages/welcome_page.dart';
import 'package:spent/presentation/widgets/logo.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthenticationBloc>(context).add(InitialUser());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animationController.forward();
  }

  Widget _buildLogo() {
    return FadeTransition(
      opacity: _animation,
      child: Logo(),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return BlocConsumer<AuthenticationBloc, AuthenticationState>(
  //     // listenWhen: (previous, current) {
  //     //   print(previous);
  //     //   print(current);
  //     //   return true;
  //     // },
  //     listener: (context, state) {
  //       print(state);
  //       if (state is AuthenticationAuthenticated) {
  //         Navigator.of(context).pushReplacement(PageRouteBuilder(
  //             transitionDuration: Duration(milliseconds: 600), pageBuilder: (_, __, ___) => AppScreen()));
  //       } else if (state is AuthenticationInitial || state is AuthenticationLoading) {
  //         Navigator.of(context).pushReplacement(PageRouteBuilder(
  //             transitionDuration: Duration(milliseconds: 600),
  //             pageBuilder: (_, __, ___) => Scaffold(
  //                   body: Center(
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [_buildLogo()],
  //                     ),
  //                   ),
  //                 )));
  //       } else {
  //         Navigator.of(context).pushReplacement(PageRouteBuilder(
  //             transitionDuration: Duration(milliseconds: 600), pageBuilder: (_, __, ___) => WelcomePage()));
  //       }
  //     },
  //     builder: (context, state) => Scaffold(
  //       body: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [_buildLogo()],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return AppScreen();
        } else if (state is AuthenticationInitial || state is AuthenticationLoading) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buildLogo()],
              ),
            ),
          );
        } else {
          return WelcomePage();
        }
      },
    );
  }
}