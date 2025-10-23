# Credenciales de Prueba - StockPoint App

## Usuarios Disponibles para Testing

### Distribuidor
- **Email:** `juan@stockpoint.com`
- **Contraseña:** `123456`
- **Rol:** distribuidor
- **Navegación:** Después del login, redirige automáticamente a `/distribuidor/pedidos-recientes`
- **Funcionalidades disponibles:**
  - Ver pedidos recientes
  - Buscar clientes
  - Buscar productos
  - Ver productos agregados al carrito
  - Crear nuevos pedidos

### Administrador
- **Email:** `admin@stockpoint.com`
- **Contraseña:** `admin123`
- **Rol:** administrador
- **Navegación:** Después del login, redirige a la pantalla Home (por ahora)

## Flujo de Autenticación Corregido

### Registro
1. El usuario se registra con sus datos
2. Los datos se guardan temporalmente en `MockDataService`
3. Después del registro exitoso, se redirige al Login
4. El usuario puede iniciar sesión con las credenciales recién creadas

### Login
1. El sistema valida las credenciales contra `MockDataService`
2. Si las credenciales son correctas:
   - Si el rol es "distribuidor": redirige a `/distribuidor/pedidos-recientes`
   - Si el rol es "administrador": redirige a `/home`
3. Si las credenciales son incorrectas: muestra mensaje de error

### Logout
- Limpia la sesión del usuario
- Redirige al Login

## Notas Técnicas
- Los datos se almacenan en memoria (se pierden al reiniciar la app)
- La validación de credenciales ahora funciona correctamente
- La navegación se basa en el rol del usuario autenticado