import 'package:equatable/equatable.dart';
import '../../data/models/bus_model.dart';


abstract class BusState extends Equatable {
  @override
  List<Object> get props => [];
}

class BusInitial extends BusState {}

class BusLoading extends BusState {}

class BusSuccess extends BusState {
  final List<BusModel> buses;

  BusSuccess({required this.buses});

  @override
  List<Object> get props => [buses];
}


class BusError extends BusState {
  final String message;

  BusError({required this.message});

  @override
  List<Object> get props => [message];
}
