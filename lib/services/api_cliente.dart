import 'package:flutter/foundation.dart';
import 'package:fronted_practico/models/cliente_model.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';

class APICliente {
  static var client = http.Client();

  // Método para obtener una lista de clientes
  static Future<List<ClienteModel>?> getClientes() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.clientesAPI, // Asegúrate de definir clientesAPI en Config
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(clientesFromJson, response.body);
    } else {
      return null;
    }
  }

  // Método para guardar un cliente (crear o editar)
  static Future<bool> saveCliente(
    ClienteModel model,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    var clienteURL = "${Config.clientesAPI}/";

    if (isEditMode) {
      clienteURL = "$clienteURL${model.id.toString()}/";
    }

    var url = Uri.http(Config.apiURL, clienteURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["nombre"] = model.nombre!;
    request.fields["apellido"] = model.apellido!;
    request.fields["correo"] = model.correo!;

    if (model.imagen != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'imagen',
        model.imagen!,
      );

      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  // Método para eliminar un cliente por ID
  static Future<bool> deleteCliente(clienteId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.clientesAPI}/$clienteId/");

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
