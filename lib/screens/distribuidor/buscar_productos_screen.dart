import 'package:flutter/material.dart';
import 'package:stockpoint_app/data/mock_data_service.dart';
import 'package:stockpoint_app/widgets/distribuidor_header.dart';
import 'package:stockpoint_app/config/app_routes.dart';
import 'package:stockpoint_app/models/producto.dart';

class BuscarProductosScreen extends StatefulWidget {
  const BuscarProductosScreen({Key? key}) : super(key: key);

  @override
  State<BuscarProductosScreen> createState() => _BuscarProductosScreenState();
}

class _BuscarProductosScreenState extends State<BuscarProductosScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Producto> _productosFiltrados = [];
  Map<String, int> _cantidades = {};

  @override
  void initState() {
    super.initState();
    _productosFiltrados = MockDataService.productos;
    // Inicializar cantidades desde productos agregados
    for (var detalle in MockDataService.productosAgregados) {
      _cantidades[detalle.producto.id] = detalle.cantidad;
    }
  }

  void _filtrarProductos(String query) {
    setState(() {
      _productosFiltrados = MockDataService.productos
          .where((producto) =>
              producto.nombre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _actualizarCantidad(Producto producto, bool incrementar) {
    setState(() {
      int cantidad = _cantidades[producto.id] ?? 0;
      if (incrementar) {
        cantidad++;
      } else if (cantidad > 0) {
        cantidad--;
      }
      _cantidades[producto.id] = cantidad;
      MockDataService.agregarProducto(producto, cantidad);
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
                hintText: 'Buscar producto...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _filtrarProductos,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _productosFiltrados.length,
                itemBuilder: (context, index) {
                  final producto = _productosFiltrados[index];
                  final cantidad = _cantidades[producto.id] ?? 0;
                  
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.network(
                            producto.foto,
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
                                  producto.nombre,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$${producto.precio.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => _actualizarCantidad(producto, false),
                              ),
                              Text(
                                cantidad.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => _actualizarCantidad(producto, true),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                  Navigator.pushNamed(context, AppRoutes.productosAgregados);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Agregar Productos',
                  style: TextStyle(fontSize: 16),
                ),
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