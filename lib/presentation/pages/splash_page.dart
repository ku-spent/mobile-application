import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spent/presentation/pages/app_screen.dart';
import 'package:spent/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:spent/presentation/bloc/network/network_bloc.dart';
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
    BlocProvider.of<NetworkBloc>(context).add(ListenNetworkConnection());
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) => BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationUnAuthenticated || state is AuthenticationError) {
            ExtendedNavigator.of(context).popUntilRoot();
          }
        },
        builder: (context, state) {
          // print(state);
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
      ),
    );
  }
}
