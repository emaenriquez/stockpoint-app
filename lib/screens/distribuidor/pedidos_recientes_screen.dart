import 'package:flutter/material.dart';
import 'package:stockpoint_app/data/mock_data_service.dart';
import 'package:stockpoint_app/widgets/distribuidor_header.dart';
import 'package:stockpoint_app/config/app_routes.dart';
import 'package:intl/intl.dart';

class PedidosRecientesScreen extends StatelessWidget {
  const PedidosRecientesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DistribuidorHeader(titulo: 'Panel de Distribuidor'),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text(
              'Pedidos Recientes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: MockDataService.pedidos.length,
                itemBuilder: (context, index) {
                  final pedido = MockDataService.pedidos[index];
                  return Card(
                    child: ListTile(
                      title: Text(pedido.cliente.nombre),
                      subtitle: Text(
                        DateFormat('dd/MM/yyyy HH:mm').format(pedido.fechaPedido),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Ver detalles del pedido (implementación futura)
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  MockDataService.limpiarProductosAgregados();
                  Navigator.pushNamed(context, AppRoutes.buscarClientes);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Nuevo Pedido',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}