import 'package:flutter/material.dart';
import '../../data/mock_data_service.dart';
import '../../models/cliente.dart';

class BuscarClientesScreen extends StatefulWidget {
  const BuscarClientesScreen({super.key});

  @override
  State<BuscarClientesScreen> createState() => _BuscarClientesScreenState();
}

class _BuscarClientesScreenState extends State<BuscarClientesScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final List<Cliente> clientesFiltrados = MockDataService.clientes
        .where((c) => c.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Clientes'),
        actions: [
          if (MockDataService.usuarioActual != null)
            CircleAvatar(
              backgroundImage:
                  AssetImage(MockDataService.usuarioActual!.foto),
            ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar cliente...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => query = value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: clientesFiltrados.length,
              itemBuilder: (context, index) {
                final cliente = clientesFiltrados[index];
                return ListTile(
                  title: Text(cliente.nombre),
                  subtitle: Text(cliente.direccion),
                  trailing: Text(cliente.telefono),
                  onTap: () {
                    MockDataService.clienteSeleccionado = cliente;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Cliente seleccionado: ${cliente.nombre}')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
