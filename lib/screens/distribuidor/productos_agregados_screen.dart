import 'package:flutter/material.dart';
import '../../data/mock_data_service.dart';
import '../../models/detalle_pedido.dart';

class ProductosAgregadosScreen extends StatefulWidget {
  const ProductosAgregadosScreen({super.key});

  @override
  State<ProductosAgregadosScreen> createState() =>
      _ProductosAgregadosScreenState();
}

class _ProductosAgregadosScreenState extends State<ProductosAgregadosScreen> {
  @override
  Widget build(BuildContext context) {
    final productosAgregados = MockDataService.productosAgregados;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos Agregados'),
        actions: [
          if (MockDataService.usuarioActual != null)
            CircleAvatar(
              backgroundImage: AssetImage(MockDataService.usuarioActual!.foto),
            ),
          const SizedBox(width: 16),
        ],
      ),
      body: productosAgregados.isEmpty
          ? const Center(child: Text('No hay productos agregados.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: productosAgregados.length,
              itemBuilder: (context, index) {
                final DetallePedido detalle = productosAgregados[index];
                return ListTile(
                  title: Text(detalle.producto.nombre),
                  subtitle: Text(
                    'Cantidad: ${detalle.cantidad}  |  Subtotal: \$${detalle.subtotal.toStringAsFixed(2)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        MockDataService.actualizarCantidad(
                        detalle.producto.id,
                          0,
                        );
                      });
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Total: \$${MockDataService.calcularTotal().toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
