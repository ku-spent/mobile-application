import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/bloc/navigation/navigation_bloc.dart';

class BottomNavbar extends StatelessWidget {
  final ScrollController scrollController;
  final PageController pageController;

  const BottomNavbar({Key key, this.scrollController, this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _scrollToTop(int index, int currentIndex) {
      if (scrollController != null && currentIndex == index)
        scrollController.animateTo(scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 270), curve: Curves.easeInExpo);
    }

    void _handleItemClick(BuildContext context, int index, int currentIndex) {
      NavItem item = NavItem.values[index];
      _scrollToTop(index, currentIndex);
      BlocProvider.of<NavigationBloc>(context).add(NavigateTo(item));
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 150), curve: Curves.easeOut);
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
