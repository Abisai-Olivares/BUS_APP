class CompanyModel {
  final int company_id;
  final String nombre;
  final String direccion;
  final String telefono;

  CompanyModel({
    required this.company_id,
    required this.nombre,
    required this.direccion,
    required this.telefono,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      company_id: json['company_id'],
      nombre: json['nombre'],
      direccion: json['direccion'],
      telefono: json['telefono'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_id': company_id,
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
    };
  }
}
