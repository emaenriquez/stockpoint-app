import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data_service.dart';
import '../../models/pedido.dart';
import '../../services/auth_service.dart';

class PedidosRecientesScreen extends StatelessWidget {
  const PedidosRecientesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pedidos = MockDataService.pedidos;
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos Recientes'),
        automaticallyImplyLeading: false,
        actions: [
          if (user != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(user.foto),
              ),
            ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                authService.logout();
                context.go('/login');
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Cerrar Sesión'),
                  ],
                ),
              ),
            ],
          ),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // Pedidos Recientes está seleccionado
        onTap: (index) {
          switch (index) {
            case 0:
              // Ya estamos en Pedidos Recientes
              break;
            case 1:
              context.go('/distribuidor/buscar-clientes');
              break;
            case 2:
              context.go('/distribuidor/buscar-productos');
              break;
            case 3:
              context.go('/distribuidor/productos-agregados');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Clientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go('/distribuidor/buscar-clientes');
        },
        label: const Text('Nuevo Pedido'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
