part of 'network_bloc.dart';

abstract class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object> get props => [];
}

class ListenNetworkConnection extends NetworkEvent {}

class NetworkConnectionChanged extends NetworkEvent {
  final NetworkState connection;
  const NetworkConnectionChanged(this.connection);
}
