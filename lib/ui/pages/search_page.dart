import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/bloc/search/search_bloc.dart';
import 'package:spent/ui/widgets/search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SearchBloc(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              fit: StackFit.expand,
              children: [
                Center(child: Text('search')),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: SearchBar(),
                )
              ],
            )));
  }
}
