import 'package:flutter/material.dart';
import 'package:stockpoint_app/data/mock_data_service.dart';
import 'package:stockpoint_app/widgets/distribuidor_header.dart';
import 'package:stockpoint_app/config/app_routes.dart';
import 'package:stockpoint_app/models/cliente.dart';

class BuscarClientesScreen extends StatefulWidget {
  const BuscarClientesScreen({Key? key}) : super(key: key);

  @override
  State<BuscarClientesScreen> createState() => _BuscarClientesScreenState();
}

class _BuscarClientesScreenState extends State<BuscarClientesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Cliente> _clientesFiltrados = [];

  @override
  void initState() {
    super.initState();
    _clientesFiltrados = MockDataService.clientes;
  }

  void _filtrarClientes(String query) {
    setState(() {
      _clientesFiltrados = MockDataService.clientes
          .where((cliente) =>
              cliente.nombre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DistribuidorHeader(titulo: 'Panel de Distribuidor'),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar cliente...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _filtrarClientes,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _clientesFiltrados.length,
                itemBuilder: (context, index) {
                  final cliente = _clientesFiltrados[index];
                  return Card(
                    child: ListTile(
                      title: Text(cliente.nombre),
                      subtitle: Text(cliente.direccion),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        MockDataService.clienteSeleccionado = cliente;
                        Navigator.pushNamed(context, AppRoutes.buscarProductos);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}