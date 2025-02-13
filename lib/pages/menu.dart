import 'package:flutter/material.dart';
import '../layout/layout.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Layout(
      child: Center(child: Text("Pagina para Dashboar", style: TextStyle(fontSize: 24))),
    );
  }
}

