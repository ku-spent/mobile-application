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
  page_following,
  page_bookmark,
  page_history,
  page_setting,
  page_about,
}

const Map<NavItem, String> PageName = {
  NavItem.page_home: 'หน้าแรก',
  NavItem.page_following: 'การติดตาม',
  NavItem.page_bookmark: 'ที่บันทึกไว้',
  NavItem.page_history: 'ประวัติการอ่าน',
  NavItem.page_setting: 'ตั้งค่า',
  NavItem.page_about: 'เกี่ยวกับ',
};
