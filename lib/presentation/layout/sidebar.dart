import 'package:flutter/material.dart';
import '../constants/theme.dart'; // Archivo opcional para colores


class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  // ignore: unused_field
  String _selectedRoute = '/'; // Ruta inicial

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFD242531), // Fondo oscuro en todo el Sidebar
        child: Column(
          children: [
            // Header del sidebar
            DrawerHeader(
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset('assets/logo.png', width: 70, height: 70),
                  const SizedBox(height: 10),
                  // Nombre de usuario
                  const Text(
                    "User Name Fast",
                    style: TextStyle(color: AppColors.textWhite, fontSize: 16),
                  ),
                ],
              ),
            ),
            // Línea divisoria
            const Divider(color: Colors.grey, indent: 20, endIndent: 20),
            // Lista de opciones
            _buildMenuItem(context, Icons.home, "Menu", '/menu'),
            _buildMenuItem(context, Icons.supervised_user_circle_outlined, "Gestion de Usuarios", '/user_manag'),
            _buildMenuItem(context, Icons.history, "Historial", '/historial'),
            _buildMenuItem(context, Icons.directions_run, "Nivel de Actividad", '/Nivel_Actividad'),
            _buildMenuItem(context, Icons.notifications, "Notificaciones", '/Notificaciones'),
            _buildMenuItem(context, Icons.handshake, "Diagnostico", '/diagnostico'),
            _buildMenuItem(context, Icons.settings_accessibility, "Plan Personalizado", '/plan_personalizado'),
            _buildMenuItem(context, Icons.recommend_outlined, "Recomendaciones", '/recomendaciones'),
            _buildMenuItem(context, Icons.exit_to_app, "Salir", '/login'), // Simulación de salida
          ],
        ),
      ),
    );
  }

  // Método para construir un ítem del menú
  Widget _buildMenuItem(BuildContext context, IconData icon, String title, String route) {
    // Verificamos si la ruta actual es la misma que la opción en el menú
    bool isSelected = ModalRoute.of(context)?.settings.name == route;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRoute = route; // Actualizamos la ruta seleccionada
        });
        Navigator.pushNamed(context, route); // Navegamos a la ruta seleccionada
      },
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF045FF3), // Azul a la izquierda
                    Color(0x4FFFFFFF), // Blanco a la derecha
                  ],
                  stops: const [0.0, 1.0],
                ),
              )
            : null, // Si no está seleccionado, no aplicamos ningún gradiente
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: TextStyle(
              color: isSelected ? AppColors.textWhite : Colors.grey[400], // Cambiar el color del texto
            ),
          ),
        ),
      ),
    );
  }
}
