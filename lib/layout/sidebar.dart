import 'package:flutter/material.dart';
import '../theme.dart'; // Archivo opcional para colores

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          //header del sidebar
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: AppColors.backroundGradient, //fondo degradiente2
            ),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Image.asset('assets/logo.png', width: 70, height: 70,),
                const SizedBox(height: 10,),

                //nombre de usuario
                const Text(
                  "User Name Fast",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
             ),
          ),

          //linea divisoria
          const Divider(color: Colors.grey, indent: 20, endIndent: 20,),

          //lista de opciones
          _buildMenuItem(context, Icons.home, "Menu", '/menu'),
          _buildMenuItem(context, Icons.history, "Historial", '/historial'),
          _buildMenuItem(context, Icons.directions_run, "Nivel de Actividad", '/Nivel_Actividad'),
          _buildMenuItem(context, Icons.notifications, "Notificaciones", '/Notificaciones'),
          _buildMenuItem(context, Icons.handshake, "Diagnostico", '/diagnostico'),
          _buildMenuItem(context, Icons.settings_accessibility, "Plan Personalizado", '/plan_personalizado'),
          _buildMenuItem(context, Icons.recommend_outlined, "Recomendaciones", '/recomendaciones'),
          _buildMenuItem(context, Icons.exit_to_app, "Salir", '/'), // Simulación de salida
        ],
      ),
    );
  }
  
  // Método para construir un ítem del menú
  Widget _buildMenuItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue,),
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, route); 
      },
    );
  }
}