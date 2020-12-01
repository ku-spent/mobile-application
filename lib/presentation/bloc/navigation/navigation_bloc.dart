import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:spent/presentation/bloc/authentication/authentication_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

@injectable
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final PageController pageController;

  final AuthenticationBloc _authenticationBloc;

  bool _isNavigating = false;

  NavigationBloc(@factoryParam this.pageController, this._authenticationBloc) : super(NavigationInitial());

  int _getIndex(NavItem item) => NavItem.values.indexWhere((e) => e == item);

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (!_isNavigating && event is NavigateTo) {
      yield* _mapNavigateToState(event);
    } else if (event is NavigateSignout) {
      yield* _mapNavigateSignoutToState(event);
    }
  }

  Stream<NavigationState> _mapNavigateSignoutToState(NavigateSignout event) async* {
    try {
      _authenticationBloc.add(UserSignedOut());
      yield NavigationInitial();
    } catch (err) {
      print(err);
    }
  }

  Stream<NavigationState> _mapNavigateToState(NavigateTo event) async* {
    _isNavigating = true;
    if (event.destination != state.selectedPage) {
      int index = _getIndex(event.destination);
      if (index >= 0) {
        pageController.animateToPage(index, duration: const Duration(milliseconds: 150), curve: Curves.easeOut);
      }
      yield NavigationState(event.destination, index);
    }
    // debounce
    Future.delayed(const Duration(milliseconds: 100), () {
      _isNavigating = false;
    });
  }
}
