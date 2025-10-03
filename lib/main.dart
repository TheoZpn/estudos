import 'package:flutter/material.dart';

import 'package:estudo/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Livros CRUD',
      theme: ThemeData(primarySwatch: Colors.blueGrey, useMaterial3: true),

      home: const HomeScreen(),

      debugShowCheckedModeBanner: false,
    );
  }
}
