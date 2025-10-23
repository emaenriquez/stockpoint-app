import 'package:flutter/material.dart';
import '../../data/mock_data_service.dart';
import '../../models/producto.dart';

class BuscarProductosScreen extends StatefulWidget {
  const BuscarProductosScreen({super.key});

  @override
  State<BuscarProductosScreen> createState() => _BuscarProductosScreenState();
}

class _BuscarProductosScreenState extends State<BuscarProductosScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final productosFiltrados = MockDataService.productos
        .where((p) => p.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Productos'),
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
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar producto...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => query = value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productosFiltrados.length,
              itemBuilder: (context, index) {
                final producto = productosFiltrados[index];
                return Card(
                  child: ListTile(
                    leading: Image.asset(producto.foto, width: 50, height: 50),
                    title: Text(producto.nombre),
                    subtitle: Text('Stock: ${producto.stock}'),
                    trailing: Text('\$${producto.precio.toStringAsFixed(2)}'),
                    onTap: () {
                      MockDataService.agregarProducto(producto, 1);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${producto.nombre} agregado')),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
