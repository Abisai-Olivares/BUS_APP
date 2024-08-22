import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/bus_model.dart';
import '../../data/models/company_model.dart';
import '../../data/repository/bus_repository.dart';
import '../cubit/bus_cubit.dart';
import '../cubit/company_cubit.dart';  // Importa el cubit de Company
import '../cubit/bus_state.dart';
import '../cubit/company_state.dart';  // Importa el estado de Company

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
  late String? _selectedCompanyId; // El ID de la compañía seleccionada

  @override
  void initState() {
    super.initState();
    // Cargar las compañías al iniciar la pantalla
    final companyCubit = BlocProvider.of<CompanyCubit>(context);
    companyCubit.fetchAllCompanies();
  }

  void _addBus() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_selectedCompanyId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, selecciona una compañía')),
        );
        return;
      }

      final newBus = BusModel(
        id: 0, 
        marca: _marca,
        modelo: _modelo,
        capacidad: _capacidad,
        tipo: _tipo,
        company_id: _selectedCompanyId!,
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
        title: const Text('Crear autobús'),
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
              BlocBuilder<CompanyCubit, CompanyState>(
                builder: (context, state) {
                  if (state is CompanyLoading) {
                    return CircularProgressIndicator();
                  } else if (state is CompanySuccess) {
                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Compañía'),
                      items: state.companies.map((company) {
                        return DropdownMenuItem<String>(
                          value: company.company_id.toString(),
                          child: Text(company.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCompanyId = value;
                        });
                      },
                      validator: (value) => value == null ? 'Campo requerido' : null,
                    );
                  } else if (state is CompanyError) {
                    return Text('Error al cargar compañías');
                  } else {
                    return SizedBox();
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addBus,
                child: const Text('Crear autobús'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
