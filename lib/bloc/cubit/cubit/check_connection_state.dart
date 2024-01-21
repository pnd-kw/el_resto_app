part of 'check_connection_cubit.dart';

class CheckConnectionState extends Equatable {
  const CheckConnectionState();

  @override
  List<Object> get props => [];
}

final class ConnectionInitial extends CheckConnectionState {}

final class Connected extends CheckConnectionState {}

final class Disconnected extends CheckConnectionState {}
