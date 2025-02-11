import 'package:flutter/material.dart';
import '../layout/layout.dart';

class AcercaDePage extends StatelessWidget {
  const AcercaDePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Layout(
      child: Center(child: Text("Hola Acerca de", style: TextStyle(fontSize: 24))),
    );
  }
}
