import 'package:bloc/bloc.dart';
import '../../data/models/bus_model.dart';
import '../../data/repository/bus_repository.dart';
import 'bus_state.dart';

class BusCubit extends Cubit<BusState> {
  final BusRepository busRepository;

  BusCubit({required this.busRepository}) : super(BusInitial());

  Future<void> fetchAllBuses() async {
    try {
      emit(BusLoading());
      final buses = await busRepository.getAllBuses();
      emit(BusSuccess(buses: buses));
    } catch (e) {
      emit(BusError(message: e.toString()));
    }
  }

  Future<void> updateBus(BusModel bus) async {
    try {
      emit(BusLoading());
      await busRepository.updateBus(bus); 
      final buses = await busRepository.getAllBuses();
      emit(BusSuccess(buses: buses));
    } catch (e) {
      emit(BusError(message: e.toString()));
    }
  }
  
   Future<void> deleteBus(int busId) async {
    try {
      await busRepository.deleteBus(busId);
      fetchAllBuses();
    } catch (e) {
      emit(BusError(message: e.toString()));
    }
  }
  
  Future<void> addBus(BusModel bus) async {
  try {
      emit(BusLoading());
      await busRepository.addBus(bus); 
      fetchAllBuses();
  } catch (e) {
    emit(BusError(message: e.toString()));
  }
}
  
}
