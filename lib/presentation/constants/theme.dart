import 'package:flutter/material.dart';

class AppColors {
  //colo de letras 
  static const Color textWhite = Colors.white;

  //degradado de fondo
  static const Gradient backroundGradient = LinearGradient(
    colors:[Color(0xFF3139A8), Color(0xFF0062C7), Color(0xFF552394), Color(0xFFA339B5), Color(0xFF77289D),],
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
    //colors: [Color(0xFF23AABB), Color(0xFF0CF1F1)],
    colors: [Color(0xFF007AFF), Color(0xFF0052D4)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Degradado para botones secundarios
  static const Gradient secondaryButtonGradient = LinearGradient(
    //colors: [Color(0xFF6DCFFA), Color(0xFF2737CF)],
    colors: [Color(0xFFB5179E), Color(0xFF7209B7)],
    //colors: [Color(0xFFFF6B00), Color(0xFFD90429)], //boton tercerio
    // colors: [Color(0xFF00C9A7), Color(0xFF008F7A)], // Verde agua a turquesa oscuro
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Degradado para botones terceros
  static const Gradient tercerButtonGradient = LinearGradient(
    colors: [Color(0xFF032D60), Color(0xFF0A1167), Color(0xFF010317)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}