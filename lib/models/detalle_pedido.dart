import 'producto.dart';

class DetallePedido {
  final int id;
  final Producto producto;
  final int cantidad;
  final double subtotal;

  DetallePedido({
    required this.id,
    required this.producto,
    required this.cantidad,
  }) : subtotal = producto.precio * cantidad;
}
