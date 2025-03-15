import 'package:flutter/material.dart';
import '../../layout/sidebar.dart';
import '../../constants/theme.dart';
import 'enroll_students_page.dart';

class ManagementPage extends StatelessWidget {
  const ManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("GESTIÓN DE ALUMNOS",
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.backroundGradient,
          ),
          child: Center( // Centra el contenido
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
              crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente
              children: [
                const SizedBox(height: 50), // Espaciado adicional para bajar el título

                const SizedBox(height: 20), // Espaciado entre título y botones
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.85,
                      children: const [
                        AnimatedActivityCard(
                          icon: Icons.person_add_alt_1,
                          title: 'MATRICULAR ALUMNOS',
                          description: 'Registro de nuevos estudiantes',
                          gradient: LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          route: UserListPage(),
                        ),
                        AnimatedActivityCard(
                          icon: Icons.fitness_center,
                          title: 'ASIGNAR RUTINA',
                          description: 'Crear planes de entrenamiento',
                          gradient: LinearGradient(
                            colors: [Color(0xFF10B981), Color(0xFF059669)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          route: AssignRoutinePage(),
                        ),
                        AnimatedActivityCard(
                          icon: Icons.restaurant,
                          title: 'ASIGNAR DIETA',
                          description: 'Planes nutricionales personalizados',
                          gradient: LinearGradient(
                            colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          route: AssignDietPage(),
                        ),
                        AnimatedActivityCard(
                          icon: Icons.tips_and_updates,
                          title: 'RECOMENDACIONES',
                          description: 'Consejos personalizados',
                          gradient: LinearGradient(
                            colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          route: AssignRecommendationsPage(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

class AnimatedActivityCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final LinearGradient gradient;
  final Widget route;

  const AnimatedActivityCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
    required this.route,
    super.key,
  });

  @override
  _AnimatedActivityCardState createState() => _AnimatedActivityCardState();
}

class _AnimatedActivityCardState extends State<AnimatedActivityCard> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.route),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()
            ..scale(_isPressed ? 0.95 : _isHovered ? 1.05 : 1.0),
          curve: Curves.easeOutBack,
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isHovered ? 0.3 : 0.2),
                blurRadius: _isHovered ? 20 : 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: ConstrainedBox( // Restricciones de tamaño añadidas
            constraints: const BoxConstraints(
              minHeight: 150,
              maxHeight: 180,
              minWidth: 150,
              maxWidth: 200,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12), // Padding reducido
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribución mejorada
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.icon,
                      size: 36, // Tamaño de icono ajustado
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16, // Tamaño de fuente reducido
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          blurRadius: 2,
                          offset: Offset(1, 1),
                        )
                      ],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12, // Tamaño de fuente reducido
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EnrollStudentsPage extends StatelessWidget {
  const EnrollStudentsPage({super.key}); // Nombre del constructor corregido

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Matricular Alumnos')),
      body: const Center(child: Text('Formulario de matrícula aquí')),
    );
  }
}

class AssignRoutinePage extends StatelessWidget {
  const AssignRoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Asignar Rutina')),
      body: const Center(child: Text('Selector de rutinas aquí')),
    );
  }
}

class AssignDietPage extends StatelessWidget {
  const AssignDietPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Asignar Dieta')),
      body: const Center(child: Text('Editor de planes nutricionales aquí')),
    );
  }
}

class AssignRecommendationsPage extends StatelessWidget {
  const AssignRecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recomendaciones')),
      body: const Center(child: Text('Sistema de recomendaciones aquí')),
    );
  }
}