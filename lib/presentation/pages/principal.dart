import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../constants/theme.dart'; //importamos colores
import '../constants/widgets.dart'; //importamos botones

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  const BoxDecoration(
          gradient: AppColors.backroundGradient,//fondo gradiennte
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // Carrusel de imágenes
              CarouselSlider(
                options: CarouselOptions(
                  height: 600, // Altura del carrusel
                  autoPlay: true, // Reproducción automática
                  autoPlayInterval: const Duration(seconds: 3), // Intervalo de cambio
                  enlargeCenterPage: true, // Efecto de zoom en la imagen activa
                  viewportFraction: 0.8, // Tamaño de cada imagen en la vista
                  aspectRatio: 16 / 9,
                ),
                items: [
                  'assets/carousel/image1.jpg',
                  'assets/carousel/image2.jpg',
                  'assets/carousel/image3.jpg',
                  'assets/carousel/image4.jpg',
                  'assets/carousel/image5.jpg',
                ].map((imagePath) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Bordes redondeados
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: 400,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              //boton
              SizedBox(
                width: 250,
                height: 50,
                child: GradientButton(
                  text: "Continuar",
                  gradient: AppColors.primaryButtonGradient,
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  icon: Icons.arrow_forward_ios_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}