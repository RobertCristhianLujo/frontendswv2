import 'package:flutter/material.dart';
import 'package:fronted_practico/models/cliente_model.dart';
import 'package:fronted_practico/pages/cliente/cliente_item.dart';
import 'package:fronted_practico/services/api_cliente.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class ClientesList extends StatefulWidget {
  const ClientesList({super.key});

  @override
  _ClientesListState createState() => _ClientesListState();
}

class _ClientesListState extends State<ClientesList> {
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Clientes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {}); // Refresca la lista
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: loadClientes(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-cliente');
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget loadClientes() {
    return FutureBuilder(
      future: APICliente.getClientes(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<ClienteModel>?> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error al cargar los clientes: ${snapshot.error}"),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("No hay clientes disponibles."),
          );
        } else {
          return clienteList(snapshot.data!);
        }
      },
    );
  }

  Widget clienteList(List<ClienteModel> clientes) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      itemCount: clientes.length,
      itemBuilder: (context, index) {
        return ClienteItem(
          model: clientes[index],
          onDelete: (ClienteModel model) {
            setState(() {
              isApiCallProcess = true;
            });

            APICliente.deleteCliente(model as int).then(
              (response) {
                setState(() {
                  isApiCallProcess = false;
                  clientes.removeWhere((item) => item.id == model.id);
                });
              },
            );
          },
        );
      },
    );
  }
}
