import 'package:flutter/material.dart';
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
              //imagene del logo
              Image.asset('assets/logo.png', width: 200, height: 400,),
              const SizedBox( height: 20,),
              //boton
              SizedBox(
                width: 250,
                height: 50,
                child: GradientButton(
                  text: "Continuar",
                  gradient: AppColors.secondaryButtonGradient,
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}