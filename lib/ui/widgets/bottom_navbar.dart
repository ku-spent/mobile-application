import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/bloc/navigation/navigation_bloc.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _handleItemClick(BuildContext context, int index) {
      NavItem item = NavItem.values[index];
      BlocProvider.of<NavigationBloc>(context).add(NavigateTo(item));
    }

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        return BottomNavigationBar(
          currentIndex: state.currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าแรก'),
            BottomNavigationBarItem(
                icon: Icon(Icons.rss_feed_rounded), label: 'การติดตาม'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark), label: 'ที่บันทึกไว้'),
          ],
          onTap: (index) => _handleItemClick(context, index),
        );
      },
    );
  }
}

const a = NavItem.values;
