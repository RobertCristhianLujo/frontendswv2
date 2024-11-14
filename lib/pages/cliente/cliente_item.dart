import 'package:flutter/material.dart';
import '../../models/cliente_model.dart';

class ClienteItem extends StatelessWidget {
  final ClienteModel? model;
  final Function? onDelete;

  ClienteItem({
    super.key,
    this.model,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: clienteItemDetails(context),
      ),
    );
  }

  Widget clienteItemDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  (model!.imagen == null || model!.imagen!.isEmpty)
                      ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                      : model!.imagen!,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model!.nombre} ${model!.apellido}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text("✉ ${model!.correo}", style: TextStyle(color: Colors.grey[700])),
                const SizedBox(height: 5),
                Text("📞 ${model!.telefono}", style: TextStyle(color: Colors.grey[700])),
                const SizedBox(height: 5),
                Text("📍 ${model!.direccion}", style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/edit-cliente',
                    arguments: {'model': model},
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  if (onDelete != null) {
                    onDelete!(model);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

