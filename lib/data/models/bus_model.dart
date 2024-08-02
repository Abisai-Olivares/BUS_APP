class BusModel {
  final int id;
  final String marca;
  final String modelo;
  final String capacidad;
  final String tipo;

  BusModel({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.capacidad,
    required this.tipo,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      id: json['id'],
      marca: json['marca'],
      modelo: json['modelo'],
      capacidad: json['capacidad'],
      tipo: json['tipo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'capacidad': capacidad,
      'tipo': tipo,
    };
  }
}
