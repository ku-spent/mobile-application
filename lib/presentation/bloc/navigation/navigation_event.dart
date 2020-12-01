part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateTo extends NavigationEvent {
  final NavItem destination;

  const NavigateTo(this.destination);

  @override
  List<Object> get props => [destination];
}

class NavigateSignout extends NavigationEvent {}
