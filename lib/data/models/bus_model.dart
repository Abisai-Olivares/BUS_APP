import 'company_model.dart';

class BusModel {
  final int id;
  final String marca;
  final String modelo;
  final String capacidad;
  final String tipo;
  final CompanyModel? company; // Nullable para recibir datos completos
  final String? company_id; // Nullable para enviar solo el ID de la compañía

  BusModel({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.capacidad,
    required this.tipo,
    this.company, // Para cuando recibes el bus completo con los detalles de la compañía
    this.company_id, // Para cuando solo envías el ID de la compañía
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      id: json['id'],
      marca: json['marca'],
      modelo: json['modelo'],
      capacidad: json['capacidad'],
      tipo: json['tipo'],
      company: json['company'] != null 
          ? CompanyModel.fromJson(json['company']) 
          : null, // Parsear la compañía solo si está presente
      company_id: json['company_id'], // Asume que company_id está presente si no se envía el objeto completo
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'capacidad': capacidad,
      'tipo': tipo,
      'company_id': company_id, // Enviar solo el ID de la compañía si es lo único necesario
      'company': company?.toJson(), // Convertir a JSON si existe el objeto company completo
    };
  }
}
