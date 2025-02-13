import 'package:flutter/material.dart';
import 'package:iuapp/layout/sidebar.dart';
import '../constants/widgets.dart';
import '../constants/theme.dart';
import 'sedentary.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(), //se agrega el sidebar
      appBar: AppBar(
        title: const Text("NIVEL DE ACTIVIDAD"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0), 
          child: GridView.count(
            crossAxisCount: 2,// 2 columnas
            crossAxisSpacing: 10, //espacio horizontal entre tarjetas
            mainAxisSpacing: 10,//espacio vertical entre tarjetas
            children: [
              ActivityCard(
                imagePath: 'assets/sedentario.png',
                title: 'SEDENTARIO',
                description: 'Poco o ningun ejercicio.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SedentarioPage())
                  );
                },
              ),
        
              ActivityCard(
                imagePath: 'assets/sedentario.png',
                title: 'LIGERA ACTIVIDAD',
                description: 'Ejercicio ligero de 1-3 dias/semana.',
                onTap: () {
                  //Navigator.pushNamed(context, '/ligera_actividad');
                },
              ),
        
              ActivityCard(
                imagePath: 'assets/sedentario.png',
                title: 'ACTIVO',
                description: 'Ejercicio moderado de 3-5 dias/semana.',
                onTap: () {
                  //Navigator.pushNamed(context, '/actividad');
                },
              ),
        
              ActivityCard(
                imagePath: 'assets/sedentario.png',
                title: 'ATLETA',
                description: 'Entrenamiento intenso 6-7 dias/semana.',
                onTap: () {
                  //Navigator.pushNamed(context, '/atleta');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

