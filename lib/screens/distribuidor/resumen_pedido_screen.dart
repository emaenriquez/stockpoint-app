import 'package:flutter/material.dart';
import 'package:stockpoint_app/data/mock_data_service.dart';
import 'package:stockpoint_app/widgets/distribuidor_header.dart';
import 'package:stockpoint_app/config/app_routes.dart';

class ResumenPedidoScreen extends StatelessWidget {
  const ResumenPedidoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = MockDataService.calcularTotal();

    return Scaffold(
      appBar: const DistribuidorHeader(titulo: 'Panel de Distribuidor'),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen del Pedido',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Cliente: ${MockDataService.clienteSeleccionado?.nombre ?? ""}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: MockDataService.productosAgregados.length,
                itemBuilder: (context, index) {
                  final detalle = MockDataService.productosAgregados[index];
                  final subtotal = detalle.producto.precio * detalle.cantidad;

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.network(
                            detalle.producto.foto,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  detalle.producto.nombre,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Precio: \$${detalle.producto.precio.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  'Cantidad: ${detalle.cantidad}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  'Subtotal: \$${subtotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  MockDataService.limpiarProductosAgregados();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.pedidosRecientes,
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Compartir Pedido',
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