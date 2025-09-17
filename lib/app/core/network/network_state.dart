part of 'network_cubit.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

class NetworkInitial extends NetworkState {
  const NetworkInitial();
}

class NetworkConnected extends NetworkState {
  const NetworkConnected();
}

class NetworkDisconnected extends NetworkState {
  const NetworkDisconnected();
}
