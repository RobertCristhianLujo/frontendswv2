import 'dart:convert';

List<ClienteModel> clientesFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<ClienteModel>((json) => ClienteModel.fromJson(json))
      .toList();
}

class ClienteModel {
  late int? id;
  late String? nombre;
  late String? apellido;
  late String? correo;
  late String? telefono;
  late String? direccion;
  late String? imagen;

  ClienteModel({
    this.id,
    this.nombre,
    this.apellido,
    this.correo,
    this.telefono,
    this.direccion,
    this.imagen,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      id: json['id'] as int?,
      nombre: json['nombre'] as String?,
      apellido: json['apellido'] as String?,
      correo: json['correo'] as String?,
      telefono: json['telefono'] as String?,
      direccion: json['direccion'] as String?,
      imagen: json['imagen'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['apellido'] = apellido;
    data['correo'] = correo;
    data['telefono'] = telefono;
    data['direccion'] = direccion;
    data['imagen'] = imagen;
    return data;
  }
}
