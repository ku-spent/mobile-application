import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/presentation/bloc/authentication/authentication_bloc.dart';

class NavDrawerAccountHeader extends StatelessWidget {
  const NavDrawerAccountHeader({Key key}) : super(key: key);

  Widget _build(String imageUrl, String name) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.grey,
            child: ClipOval(child: CachedNetworkImage(imageUrl: imageUrl)),
          ),
          Container(width: 12.0),
          Text(
            name,
            style: GoogleFonts.kanit(fontSize: 16.0),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return _build(state.user.picture, state.user.name);
        } else {
          return _build('', '');
        }
      },
    );
  }
}
