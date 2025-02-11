import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MasaMuscularPage extends StatefulWidget {
  const MasaMuscularPage({super.key});

  @override
  _MasaMuscularPageState createState() => _MasaMuscularPageState();
}

class _MasaMuscularPageState extends State<MasaMuscularPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    //inicializamos el controlador para el video
    _controller = VideoPlayerController.asset('assets/gym.mp4')
      ..initialize().then((_) {
        print("Video cargado correctamente: ${_controller.value.isInitialized}");
        setState(() {});
        //actualiza la interfaz cuando el video este listo
        _controller.setLooping(true); // Para que el video se repita
        _controller.play(); // Para iniciar la reproducción automáticamente
      });
  }

  @override
  void dispose() {
    //no olvides liberar el controlador al final
    _controller.dispose();
    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Masa Muscular"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //video en la parte superior
            _controller.value.isInitialized
            ? SizedBox(
              height: 250,
              child: VideoPlayer(_controller),
            )
            :const Center(child: CircularProgressIndicator()),

            const SizedBox(height: 16,),

            //parrafo de introdccion
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "La fase de definición es el período en el que reducimos el porcentaje de grasa corporal manteniendo la mayor cantidad de masa muscular posible. Se logra mediante un déficit calórico controlado, entrenamiento estratégico y optimización de macronutrientes.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 16),

            // Título centrado
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "OBJETIVO PRINCIPAL",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Lista numerada de objetivos principales
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("📌 OBJETIVO PRINCIPAL", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("✅ Eliminar grasa corporal sin perder músculo"),
                  Text("✅ Mantener fuerza y rendimiento en el entrenamiento"),
                  Text("✅ Definir los músculos logrados en volumen"),
                  SizedBox(height: 8),
                  Text("📅 Duración: 8-16 semanas (según porcentaje de grasa inicial)"),
                  Text("📉 Déficit calórico: 300-500 kcal por día (sin ser agresivo)"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Párrafo importante
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "💡 IMPORTANTE: La clave es perder grasa gradualmente. Una pérdida de 0.5-1% del peso corporal por semana es ideal para minimizar la pérdida muscular.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),

            const SizedBox(height: 16),

            // Párrafo sobre cómo calcular déficit calórico
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "1️⃣ CÓMO CALCULAR TU DÉFICIT CALÓRICO\nPara definir, necesitas ingerir menos calorías de las que gastas.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
