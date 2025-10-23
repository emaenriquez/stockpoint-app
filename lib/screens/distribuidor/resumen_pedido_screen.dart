import 'package:flutter/material.dart';
import '../../data/mock_data_service.dart';
import '../../models/cliente.dart';
import '../../models/detalle_pedido.dart';

class ResumenPedidoScreen extends StatelessWidget {
  const ResumenPedidoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Cliente? cliente = MockDataService.clienteSeleccionado;
    final List<DetallePedido> productos = MockDataService.productosAgregados;
    final double total = MockDataService.calcularTotal();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen del Pedido'),
        actions: [
          if (MockDataService.usuarioActual != null)
            CircleAvatar(
              backgroundImage: AssetImage(MockDataService.usuarioActual!.foto),
            ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: cliente == null
            ? const Center(
                child: Text('Debe seleccionar un cliente para continuar.'),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cliente: ${cliente.nombre}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Dirección: ${cliente.direccion}'),
                  const SizedBox(height: 16),
                  const Text(
                    'Productos:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: productos.length,
                      itemBuilder: (context, index) {
                        final detalle = productos[index];
                        return ListTile(
                          title: Text(detalle.producto.nombre),
                          subtitle: Text(
                            'Cantidad: ${detalle.cantidad}  |  Subtotal: \$${detalle.subtotal.toStringAsFixed(2)}',
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Total: \$${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check),
                      label: const Text('Confirmar Pedido'),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Pedido confirmado exitosamente'),
                          ),
                        );
                        MockDataService.limpiarPedido();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
