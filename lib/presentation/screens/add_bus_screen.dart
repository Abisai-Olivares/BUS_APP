import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/bus_model.dart';
import '../../data/repository/bus_repository.dart';
import '../cubit/bus_cubit.dart';
import '../cubit/bus_state.dart';

class AddBusScreen extends StatefulWidget {
  const AddBusScreen({Key? key}) : super(key: key);

  @override
  _AddBusScreenState createState() => _AddBusScreenState();
}

class _AddBusScreenState extends State<AddBusScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _marca;
  late String _modelo;
  late String _capacidad;
  late String _tipo;

  void _addBus() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newBus = BusModel(
        id: 0, 
        marca: _marca,
        modelo: _modelo,
        capacidad: _capacidad,
        tipo: _tipo,
      );

      final busCubit = BlocProvider.of<BusCubit>(context);
      busCubit.addBus(newBus).then((_) {
        Navigator.pop(context);
        busCubit.fetchAllBuses(); 
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear autobus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Marca'),
                onSaved: (value) => _marca = value!,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Modelo'),
                onSaved: (value) => _modelo = value!,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Capacidad'),
                onSaved: (value) => _capacidad = value!,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tipo'),
                onSaved: (value) => _tipo = value!,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addBus,
                child: const Text('Crear autobus'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
