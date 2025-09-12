// lib/main.dart

import 'package:flutter/material.dart';
import 'package:estudo/itens/item1/item1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'exemplo de crud',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

// Lista de itens mock
final List<Item> listaDeItens = [
  Item(id: 1, nome: 'Item A'),
  Item(id: 2, nome: 'Item B'),
  Item(id: 3, nome: 'Item C'),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Itens')),
      body: ListView.builder(
        itemCount: listaDeItens.length,
        itemBuilder: (context, index) {
          final item = listaDeItens[index];
          return ListTile(title: Text(item.nome));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação para adicionar um novo item (Create)
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
