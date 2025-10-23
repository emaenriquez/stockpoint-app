import 'package:flutter/material.dart';
import '../../data/mock_data_service.dart';
import '../../models/pedido.dart';

class PedidosRecientesScreen extends StatelessWidget {
  const PedidosRecientesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pedidos = MockDataService.pedidos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos Recientes'),
        actions: [
          if (MockDataService.usuarioActual != null)
            CircleAvatar(
              backgroundImage: AssetImage(MockDataService.usuarioActual!.foto),
            ),
          const SizedBox(width: 16),
        ],
      ),
      body: pedidos.isEmpty
          ? const Center(child: Text('No hay pedidos recientes.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                final Pedido pedido = pedidos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(pedido.cliente.nombre),
                    subtitle: Text(
                      'Fecha: ${pedido.fechaPedido.day}/${pedido.fechaPedido.month}/${pedido.fechaPedido.year}',
                    ),
                    trailing: Text(
                      '\$${pedido.total.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Acción para crear nuevo pedido
        },
        label: const Text('Nuevo Pedido'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
