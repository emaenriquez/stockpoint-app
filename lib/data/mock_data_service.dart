import '../models/usuario.dart';
import '../models/cliente.dart';
import '../models/producto.dart';
import '../models/pedido.dart';
import '../models/detalle_pedido.dart';

/// Servicio de datos simulado (mock)
class MockDataService {
  static Usuario? usuarioActual;
  static Cliente? clienteSeleccionado;
  static final List<DetallePedido> productosAgregados = [];

  static final List<Usuario> usuarios = [
    Usuario(
      id: 1,
      nombre: 'Juan Pérez',
      correo: 'juan@stockpoint.com',
      contrasena: '123456',
      rol: 'distribuidor',
      foto: 'assets/avatar_distribuidor.png',
    ),
    Usuario(
      id: 2,
      nombre: 'María López',
      correo: 'admin@stockpoint.com',
      contrasena: 'admin123',
      rol: 'administrador',
      foto: 'assets/avatar_admin.png',
    ),
  ];

  static final clientes = [
    Cliente(
      id: 1,
      nombre: 'Supermercado Sol',
      direccion: 'Av. San Martín 123',
      telefono: '2615551111',
    ),
    Cliente(
      id: 2,
      nombre: 'Kiosco Luna',
      direccion: 'Calle Rivadavia 456',
      telefono: '2615552222',
    ),
  ];

  static final productos = [
    Producto(
      id: 1,
      nombre: 'Coca-Cola 1L',
      precio: 1200.0,
      foto: 'assets/products/coca.png',
      stock: 50,
    ),
    Producto(
      id: 2,
      nombre: 'Pepsi 1L',
      precio: 1100.0,
      foto: 'assets/products/pepsi.png',
      stock: 30,
    ),
    Producto(
      id: 3,
      nombre: 'Sprite 1L',
      precio: 1150.0,
      foto: 'assets/products/sprite.png',
      stock: 25,
    ),
  ];

  static final pedidos = [
    Pedido(
      id: 1,
      numeroPedido: 'SP-0001',
      fechaPedido: DateTime(2025, 10, 10),
      usuario: usuarios[0],
      cliente: clientes[0],
      detalles: [
        DetallePedido(id: 1, producto: productos[0], cantidad: 2),
        DetallePedido(id: 2, producto: productos[1], cantidad: 1),
      ],
    ),
    Pedido(
      id: 2,
      numeroPedido: 'SP-0002',
      fechaPedido: DateTime(2025, 10, 12),
      usuario: usuarios[0],
      cliente: clientes[1],
      detalles: [DetallePedido(id: 3, producto: productos[2], cantidad: 3)],
    ),
  ];

  // ==========================
  // === Métodos simulados ===
  // ==========================

  static bool login(String correo, String contrasena) {
    final user = usuarios.firstWhere(
      (u) => u.correo == correo && u.contrasena == contrasena,
      orElse: () => Usuario(
        id: -1,
        nombre: '',
        correo: '',
        contrasena: '',
        rol: '',
        foto: '',
      ),
    );

    if (user.id != -1) {
      usuarioActual = user;
      return true;
    }
    return false;
  }

  static bool registrar(String nombre, String correo, String contrasena) {
    final existe = usuarios.any((u) => u.correo == correo);
    if (existe) return false;

    final nuevo = Usuario(
      id: usuarios.length + 1,
      nombre: nombre,
      correo: correo,
      contrasena: contrasena,
      rol: 'distribuidor',
      foto: 'assets/avatar_distribuidor.png',
    );
    usuarios.add(nuevo);
    usuarioActual = nuevo;
    return true;
  }

  static bool cambiarContrasena(String nueva) {
    if (usuarioActual == null) return false;
    final index = usuarios.indexWhere((u) => u.id == usuarioActual!.id);
    if (index != -1) {
      usuarios[index] = Usuario(
        id: usuarioActual!.id,
        nombre: usuarioActual!.nombre,
        correo: usuarioActual!.correo,
        contrasena: nueva,
        rol: usuarioActual!.rol,
        foto: usuarioActual!.foto,
      );
      usuarioActual = usuarios[index];
      return true;
    }
    return false;
  }

  static void cerrarSesion() {
    usuarioActual = null;
  }

  // ===============================
  // === Métodos para distribuidores
  // ===============================
  static void agregarProducto(Producto producto, int cantidad) {
    final existente = productosAgregados.firstWhere(
      (d) => d.producto.id == producto.id,
      orElse: () => DetallePedido(
        id: DateTime.now().millisecondsSinceEpoch,
        producto: producto,
        cantidad: 0,
      ),
    );

    if (!productosAgregados.contains(existente)) {
      existente.cantidad = cantidad;
      productosAgregados.add(existente);
    } else {
      existente.cantidad = cantidad;
    }
  }

  static void actualizarCantidad(int productoId, int nuevaCantidad) {
    final index = productosAgregados.indexWhere(
      (d) => d.producto.id == productoId,
    );
    if (index != -1) {
      if (nuevaCantidad <= 0) {
        productosAgregados.removeAt(index);
      } else {
        productosAgregados[index] = DetallePedido(
          id: productosAgregados[index].id,
          producto: productosAgregados[index].producto,
          cantidad: nuevaCantidad,
        );
      }
    }
  }

  static double calcularTotal() {
    return productosAgregados.fold(
      0,
      (total, d) => total + (d.producto.precio * d.cantidad),
    );
  }

  static void limpiarPedido() {
    productosAgregados.clear();
    clienteSeleccionado = null;
  }
}
