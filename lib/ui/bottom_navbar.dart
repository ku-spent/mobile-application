import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/bloc/navigation/navigation_bloc.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _handleItemClick(BuildContext context, int index) {
      NavItem item = NavItem.values[index];
      print(item);
      BlocProvider.of<NavigationBloc>(context).add(NavigateTo(item));
    }

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        return BottomNavigationBar(
          currentIndex: state.currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.wifi), label: 'Following')
          ],
          onTap: (index) => _handleItemClick(context, index),
        );
      },
    );
  }
}

const a = NavItem.values;
