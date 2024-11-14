import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fronted_practico/pages/cliente/cliente_list.dart';
import 'package:fronted_practico/pages/inicio/inicio.dart';
import 'package:fronted_practico/producto/producto_list.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  int _selectDrawerItem = 0;
  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const inicio();
      case 1:
        return const ClientesList();
      case 2:
        return const ProductosList();
    }
  }

  _onSelectItem(int pos) {
    Navigator.of(context).pop();
    setState(() {
      _selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LUX AUTOMOTORS"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('LUX AUTOMOTORS'),
              accountEmail: Text('lujocristian0611@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(""),
              ),
            ),
            ListTile(
              title: const Text('Inicio'),
              leading: const Icon(Icons.phone),
              selected: (0 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(0);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Clientes'),
              leading: const Icon(Icons.person),
              selected: (1 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(1);
              },
            ),
            ListTile(
              title: const Text('Productos'),
              leading: const Icon(Icons.wind_power_rounded),
              selected: (2 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(2);
              },
            ),
            ListTile(
              title: const Text('Ventas'),
              leading: const Icon(Icons.production_quantity_limits),
              selected: (3 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(3);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Cerra Sessión'),
              leading: const Icon(Icons.touch_app_outlined),
              selected: (3 == _selectDrawerItem),
              onTap: () {
                exit(0);
              },
            ),
          ],
        ),
      ),
      body: getDrawerItemWidget(_selectDrawerItem),
    );
  }
}
