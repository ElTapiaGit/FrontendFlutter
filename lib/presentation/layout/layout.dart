import 'package:flutter/material.dart';
import 'sidebar.dart';

class Layout extends StatelessWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mi App"),),
      drawer: const Sidebar(), //sidebar para todas las paginas
      body: child,
    );
  }
}