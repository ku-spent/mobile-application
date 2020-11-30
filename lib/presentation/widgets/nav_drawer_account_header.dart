import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/presentation/bloc/authentication/authentication_bloc.dart';

class NavDrawerAccountHeader extends StatelessWidget {
  const NavDrawerAccountHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return UserAccountsDrawerHeader(
            accountName: Text(state.user.name, style: GoogleFonts.kanit(color: Colors.black)),
            accountEmail: Text(state.user.email, style: GoogleFonts.kanit(color: Colors.black)),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: CachedNetworkImageProvider(state.user.picture),
            ),
          );
        } else {
          return UserAccountsDrawerHeader(
            accountName: null,
            accountEmail: null,
          );
        }
      },
    );
  }
}
