import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial());

  int _getIndex(NavItem item) => NavItem.values.indexWhere((e) => e == item);

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is NavigateTo) {
      // only route to a new location if the new location is different
      if (event.destination != state.selectedPage) {
        yield NavigationState(event.destination, _getIndex(event.destination));
      }
    }
  }
}
