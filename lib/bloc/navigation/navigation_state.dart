part of 'navigation_bloc.dart';

@immutable
class NavigationState {
  final NavItem selectedPage;
  final int currentIndex;

  const NavigationState(this.selectedPage, this.currentIndex);
}

class NavigationInitial extends NavigationState {
  NavigationInitial() : super(NavItem.page_home, 0);
}

enum NavItem {
  page_home,
  page_search,
  page_following,
}
