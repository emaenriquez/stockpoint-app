import '../models/usuario.dart';
import '../models/cliente.dart';
import '../models/producto.dart';
import '../models/pedido.dart';
import '../models/detalle_pedido.dart';

// ─────────────────────────────────────────────
// USUARIOS
// ─────────────────────────────────────────────
final mockUsuarios = [
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

// ─────────────────────────────────────────────
// CLIENTES
// ─────────────────────────────────────────────
final mockClientes = [
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

// ─────────────────────────────────────────────
// PRODUCTOS
// ─────────────────────────────────────────────
final mockProductos = [
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

// ─────────────────────────────────────────────
// PEDIDOS (con DetallePedido)
// ─────────────────────────────────────────────
final mockPedidos = [
  Pedido(
    id: 1,
    numeroPedido: 'SP-0001',
    fechaPedido: DateTime(2025, 10, 10),
    usuario: mockUsuarios[0],
    cliente: mockClientes[0],
    detalles: [
      DetallePedido(id: 1, producto: mockProductos[0], cantidad: 2),
      DetallePedido(id: 2, producto: mockProductos[1], cantidad: 1),
    ],
  ),
  Pedido(
    id: 2,
    numeroPedido: 'SP-0002',
    fechaPedido: DateTime(2025, 10, 12),
    usuario: mockUsuarios[0],
    cliente: mockClientes[1],
    detalles: [DetallePedido(id: 3, producto: mockProductos[2], cantidad: 3)],
  ),
];
