import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/presentation/bloc/navigation/navigation_bloc.dart';

class BottomNavbar extends StatelessWidget {
  final ScrollController scrollController;

  const BottomNavbar({Key key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _scrollToTop(int index, int currentIndex) {
      bool isHomePage = currentIndex == 0;
      if (isHomePage && scrollController != null && currentIndex == index)
        scrollController.animateTo(scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 270), curve: Curves.easeInExpo);
    }

    void _handleItemClick(BuildContext context, int index, int currentIndex) {
      NavItem item = NavItem.values[index];
      _scrollToTop(index, currentIndex);
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
          onTap: (index) =>
              _handleItemClick(context, index, state.currentIndex),
        );
      },
    );
  }
}

const a = NavItem.values;
