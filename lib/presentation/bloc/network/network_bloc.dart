import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/core/IPv6.dart';

part 'network_event.dart';
part 'network_state.dart';

@singleton
class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  IPv6 _iPv6;
  NetworkBloc(this._iPv6) : super(NetworkInitial());

  StreamSubscription _subscription;
  bool isConnected = false;

  @override
  Stream<NetworkState> mapEventToState(
    NetworkEvent event,
  ) async* {
    if (event is ListenNetworkConnection) {
      DataConnectionChecker().addresses = _iPv6.addresses;
      _subscription = DataConnectionChecker().onStatusChange.listen((status) {
        add(NetworkConnectionChanged(
          status == DataConnectionStatus.disconnected ? NetworkConnectionError() : NetworkConnectionSuccess(),
        ));
        isConnected = status == DataConnectionStatus.connected;
        print('network changed: $status');
      });
    } else if (event is NetworkConnectionChanged) yield event.connection;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
