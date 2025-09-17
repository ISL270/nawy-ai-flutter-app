import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;
  bool _isConnected = true;

  NetworkCubit() : super(const NetworkInitial()) {
    _setupConnectivityListener();
  }

  bool get isConnected => _isConnected;

  Future<void> _setupConnectivityListener() async {
    // Initial check
    await checkConnection();

    // Listen for changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((_) async {
      await checkConnection();
    });
  }

  Future<bool> checkConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      // Check if any connectivity type is available
      final isConnected = result.any((type) => type != ConnectivityResult.none);
      return await _updateConnectionStatus(isConnected);
    } on SocketException catch (_) {
      _isConnected = false;
      emit(const NetworkDisconnected());
      return false;
    }
  }

  Future<bool> _updateConnectionStatus(bool hasConnection) async {
    bool isConnected = hasConnection;

    if (isConnected) {
      // Double check with a real internet connection
      try {
        // Try to lookup a known host
        final result = await InternetAddress.lookup('google.com');
        isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        isConnected = false;
      }
    }

    // Only emit if state changed
    if (isConnected != _isConnected) {
      _isConnected = isConnected;
      if (_isConnected) {
        emit(const NetworkConnected());
      } else {
        emit(const NetworkDisconnected());
      }
    }

    return _isConnected;
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
