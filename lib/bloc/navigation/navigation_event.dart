part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {
  const NavigationEvent();
}

class NavigateTo extends NavigationEvent {
  final NavItem destination;

  const NavigateTo(this.destination);
}
