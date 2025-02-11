import 'package:flutter/material.dart';

class AppColors {
  //colo de letras 
  static const Color textWhite = Colors.white;

  //degradado de fondo
  static const Gradient backroundGradient = LinearGradient(
    colors:[Color(0xFF0F1657), Color(0xFF000C3B)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Fondo degradado para las cards
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF2C2B6A), Color(0xFF000000)],
  );

  //degradado para botones primarios
  static const Gradient primaryButtonGradient = LinearGradient(
    colors: [Color(0xFF23AABB), Color(0xFF0CF1F1)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Degradado para botones secundarios
  static const Gradient secondaryButtonGradient = LinearGradient(
    colors: [Color(0xFF6DCFFA), Color(0xFF2737CF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}