import 'package:bloc/bloc.dart';
import '../../data/models/user_model.dart';
import '../../data/repository/user_repository.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit({required this.userRepository}) : super(UserInitial());


  Future<void> createUser(UserModel user) async {
    try {
      emit(UserLoading());
      await userRepository.createUser(user);
      final users = await userRepository.getAllUsers();
      emit(UserSuccess(users: users));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> getUser(String id) async {
    try {
      emit(UserLoading());
      final user = await userRepository.getUser(id);
      emit(UserSuccess(users: [user]));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      emit(UserLoading());
      await userRepository.updateUser(user);
      final users = await userRepository.getAllUsers();
      emit(UserSuccess(users: users));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      emit(UserLoading());
      await userRepository.deleteUser(id);
      final users = await userRepository.getAllUsers();
      emit(UserSuccess(users: users));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> fetchAllUsers() async {
    try {
      emit(UserLoading());
      final users = await userRepository.getAllUsers();
      emit(UserSuccess(users: users));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
