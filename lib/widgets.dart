import 'package:flutter/material.dart';
import 'theme.dart'; // Importamos los colores

class GradientButton extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final VoidCallback onPressed;
  final IconData? icon; // Parámetro opcional para el icono

  const GradientButton({
    super.key,
    required this.text,
    required this.gradient,
    required this.onPressed,
    this.icon, // Permite que el botón tenga un icono opcional
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(10),
      ),

      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: const Color(0x00F00A0A),
          padding: const EdgeInsets.all(0),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18),),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback onTap;

  const ActivityCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( // Detecta el toque
      onTap: onTap,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                width: 110,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Widget de la tarjeta de categoría
class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient, // Aplicamos el fondo degradado
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Título de la tarjeta (alineado a la izquierda)
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Imagen (alineada a la derecha)
                Image.asset(
                  imagePath,
                  width: 110,
                  height: 110,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

