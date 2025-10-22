import 'package:stockpoint_app/models/cliente.dart';
import 'package:stockpoint_app/models/pedido.dart';
import 'package:stockpoint_app/models/producto.dart';
import 'package:stockpoint_app/models/usuario.dart';
import 'package:stockpoint_app/models/detalle_pedido.dart';
import 'mock_data.dart';

class MockDataService {
  static List<Usuario> usuarios = mockUsuarios;
  static List<Cliente> clientes = mockClientes;
  static List<Producto> productos = mockProductos;
  static List<Pedido> pedidos = mockPedidos;
  static Usuario? usuarioActual;

  static List<DetallePedido> productosAgregados = [];
  static Cliente? clienteSeleccionado;

  static void agregarProducto(Producto producto, int cantidad) {
    final existente = productosAgregados.firstWhere(
      (detalle) => detalle.producto.id == producto.id,
      orElse: () => DetallePedido(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        producto: producto,
        cantidad: 0,
      ),
    );

    if (existente.cantidad == 0) {
      existente.cantidad = cantidad;
      productosAgregados.add(existente);
    } else {
      existente.cantidad = cantidad;
    }
  }

  static void actualizarCantidad(String productoId, int nuevaCantidad) {
    final index = productosAgregados.indexWhere(
      (detalle) => detalle.producto.id == productoId,
    );
    if (index != -1) {
      if (nuevaCantidad <= 0) {
        productosAgregados.removeAt(index);
      } else {
        productosAgregados[index].cantidad = nuevaCantidad;
      }
    }
  }

  static double calcularTotal() {
    return productosAgregados.fold(
      0,
      (total, detalle) => total + (detalle.producto.precio * detalle.cantidad),
    );
  }

  static void limpiarProductosAgregados() {
    productosAgregados.clear();
    clienteSeleccionado = null;
  }
}