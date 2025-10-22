class Usuario {
  final int id;
  final String nombre;
  final String correo;
  String contrasena;
  final String rol; // "distribuidor" o "administrador"
  final String foto;

  Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.contrasena,
    required this.rol,
    required this.foto,
  });
}
