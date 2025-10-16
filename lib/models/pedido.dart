import 'cliente.dart';
import 'usuario.dart';
import 'detalle_pedido.dart';

class Pedido {
  final int id;
  final String numeroPedido;
  final DateTime fechaPedido;
  final Usuario usuario;
  final Cliente cliente;
  final List<DetallePedido> detalles;

  Pedido({
    required this.id,
    required this.numeroPedido,
    required this.fechaPedido,
    required this.usuario,
    required this.cliente,
    required this.detalles,
  });

  double get total => detalles.fold(0, (sum, item) => sum + item.subtotal);
}
