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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: const TextStyle(color: Colors.white, fontSize: 18)),
            if (icon != null) const SizedBox(width: 10), // Espaciado entre icono y texto
            if (icon != null) // Muestra el icono si se proporciona
              Icon(icon, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}

//boton redondeado
class CircularButton extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final VoidCallback onPressed;

  const CircularButton({
    super.key,
    required this.text,
    required this.gradient,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Color(0xFF2B2A6D), width: 1),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
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
                maxLines: 3,
              ),
            ],
          ),
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
                    maxLines: 2, //permite que el texto se acomode en dos lines
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

