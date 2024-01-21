import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'check_connection_state.dart';

class CheckConnectionCubit extends Cubit<CheckConnectionState> {
  final Connectivity connectivity = Connectivity();

  CheckConnectionCubit() : super(ConnectionInitial()) {
    _initialize();
  }

  void _initialize() {
    connectivity.onConnectivityChanged.listen((result) {
      checkConnection();
    });
  }

  Future<bool> checkConnection() async {
    var connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      emit(Disconnected());
      return false;
    } else {
      emit(Connected());
      return true;
    }
  }
}
