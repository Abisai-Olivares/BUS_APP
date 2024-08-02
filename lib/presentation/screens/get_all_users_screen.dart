import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/user_repository.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: BlocProvider(
        create: (context) => UserCubit(
          userRepository: RepositoryProvider.of<UserRepository>(context),
        ),
        child: const UserListScreen(),
      ),
    );
  }
}

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context); //

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            userCubit.fetchAllUsers();
          },
          child: const Text('Fetch Users'),
        ),
        Expanded(
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserSuccess) {
                final users = state.users;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      title: Text(user.fullName),
                      subtitle: Text(user.email),
                    );
                  },
                );
              } else if (state is UserError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const Center(child: Text('Press the button to fetch users'));
            },
          ),
        ),
      ],
    );
  }
}
