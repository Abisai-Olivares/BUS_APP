import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/bus_model.dart';
import '../../data/models/company_model.dart';
import '../../data/repository/bus_repository.dart';
import '../cubit/bus_cubit.dart';
import '../cubit/company_cubit.dart'; // Importa el cubit de Company
import '../cubit/bus_state.dart';
import '../cubit/company_state.dart'; // Importa el estado de Company

class EditBusScreen extends StatefulWidget {
  final BusModel bus;

  const EditBusScreen({Key? key, required this.bus}) : super(key: key);

  @override
  _EditBusScreenState createState() => _EditBusScreenState();
}

class _EditBusScreenState extends State<EditBusScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _marca;
  late String _modelo;
  late String _capacidad;
  late String _tipo;
  String? _selectedCompanyId; // El ID de la compañía seleccionada
  List<CompanyModel> _companies = []; // Lista de compañías para el dropdown

  @override
  void initState() {
    super.initState();
    _marca = widget.bus.marca;
    _modelo = widget.bus.modelo;
    _capacidad = widget.bus.capacidad;
    _tipo = widget.bus.tipo;
    _selectedCompanyId = widget.bus.company_id; // ID de la compañía del autobús a editar

    // Cargar las compañías al iniciar la pantalla
    final companyCubit = BlocProvider.of<CompanyCubit>(context);
    companyCubit.fetchAllCompanies();
  }

  void _updateBus() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updatedBus = BusModel(
        id: widget.bus.id,
        marca: _marca,
        modelo: _modelo,
        capacidad: _capacidad,
        tipo: _tipo,
        company_id: _selectedCompanyId!,
      );

      final busCubit = BlocProvider.of<BusCubit>(context);
      busCubit.updateBus(updatedBus).then((_) {
        Navigator.pop(context);
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
        title: const Text('Editar autobús'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _marca,
                decoration: const InputDecoration(labelText: 'Marca'),
                onSaved: (value) => _marca = value!,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                initialValue: _modelo,
                decoration: const InputDecoration(labelText: 'Modelo'),
                onSaved: (value) => _modelo = value!,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                initialValue: _capacidad,
                decoration: const InputDecoration(labelText: 'Capacidad'),
                onSaved: (value) => _capacidad = value!,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                initialValue: _tipo,
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
                    _companies = state.companies; // Guardar las compañías en la lista

                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Compañía'),
                      value: _selectedCompanyId, // Seleccionar la compañía por defecto
                      items: _companies.map((company) {
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
                onPressed: _updateBus,
                child: const Text('Actualizar autobús'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
