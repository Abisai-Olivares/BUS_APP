import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/bus_repository.dart';
import '../cubit/bus_cubit.dart';
import '../cubit/bus_state.dart';
import 'edit_bus_screen.dart';
import 'add_bus_screen.dart';



class BusListView extends StatelessWidget {
  const BusListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text('Autobuses CRUD'),
  bottom: PreferredSize(
    preferredSize: Size.fromHeight(40.0), // Ajusta el tamaño según sea necesario
    child: Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Ups, algo sucedió. Cuando realices una actualización o creación, utiliza el botón de actualizar autobuses.',
          style: TextStyle(fontSize: 14.0),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ),
),
      body: BlocProvider(
        create: (context) => BusCubit(
          busRepository: RepositoryProvider.of<BusRepository>(context),
        )..fetchAllBuses(),
        child: const BusListScreen(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: BlocProvider.of<BusCubit>(context),
                child: const AddBusScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


class BusListScreen extends StatelessWidget {
  const BusListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final busCubit = BlocProvider.of<BusCubit>(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                busCubit.fetchAllBuses();
              },
              child: const Text('Acutalizar autobuses'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddBusScreen(),
                  ),
                );
              },
              child: const Text('Crear Autobús'),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<BusCubit, BusState>(
            builder: (context, state) {
              if (state is BusLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BusSuccess) {
                final buses = state.buses;
                return DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Marca')),
                    DataColumn(label: Text('Modelo')),
                    DataColumn(label: Text('Capacidad')),
                    DataColumn(label: Text('Tipo')),
                    DataColumn(label: Text('Acciones')),
                    DataColumn(label: Text('Eliminar')), 
                  ],
                  rows: buses.map((bus) {
                    return DataRow(cells: [
                      DataCell(Text(bus.id.toString())),
                      DataCell(Text(bus.marca)),
                      DataCell(Text(bus.modelo)),
                      DataCell(Text(bus.capacidad)),
                      DataCell(Text(bus.tipo)),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBusScreen(bus: bus),
                              ),
                            );
                          },
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteBus(busCubit, bus.id);
                          },
                        ),
                      ),
                    ]);
                  }).toList(),
                );
              } else if (state is BusError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const Center(child: Text('Press the button to fetch buses'));
            },
          ),
        ),
      ],
    );
  }

  void _deleteBus(BusCubit busCubit, int busId) async {
    try {
      await busCubit.deleteBus(busId);
      busCubit.fetchAllBuses(); 
    } catch (e) {
      print('Error al eliminar el autobús: $e');
    }
  }
}