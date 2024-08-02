import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/bus_repository.dart';
import 'presentation/screens/bus_list_screen.dart';
import 'presentation/cubit/bus_cubit.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => BusRepository(
            apiUrl: 'https://vm703q5lua.execute-api.us-east-2.amazonaws.com/Prod/pets',
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BusCubit>(
            create: (context) => BusCubit(
              busRepository: RepositoryProvider.of<BusRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Autobuses',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const BusListView(),
        ),
      ),
    );
  }
  }