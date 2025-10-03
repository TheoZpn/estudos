import 'package:flutter/material.dart';
import 'package:estudo/models/livro.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Livro> _livros = [
    Livro(
      id: 'l1',
      titulo: 'Dom Quixote',
      autor: 'Miguel de Cervantes',
      anoPublicacao: 1605,
      lido: true,
    ),
    Livro(
      id: 'l2',
      titulo: '1984',
      autor: 'George Orwell',
      anoPublicacao: 1949,
      lido: false,
    ),
  ];

  void _adicionarNovoLivro(String titulo, String autor, int ano) {
    final novoLivro = Livro(
      id: DateTime.now().toString(),
      titulo: titulo,
      autor: autor,
      anoPublicacao: ano,
    );

    setState(() {
      _livros.add(novoLivro);
    });
    Navigator.of(context).pop();
  }

  void _toggleLido(String id) {
    setState(() {
      final index = _livros.indexWhere((livro) => livro.id == id);
      if (index >= 0) {
        _livros[index].lido = !_livros[index].lido;
      }
    });
  }

  void _deletarLivro(String id) {
    setState(() {
      _livros.removeWhere((livro) => livro.id == id);
    });
  }

  void _mostrarFormularioAdicao(BuildContext ctx) {
    final _tituloController = TextEditingController();
    final _autorController = TextEditingController();
    final _anoController = TextEditingController();

    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  controller: _tituloController,
                  decoration: const InputDecoration(labelText: 'Título'),
                ),
                TextField(
                  controller: _autorController,
                  decoration: const InputDecoration(labelText: 'Autor'),
                ),
                TextField(
                  controller: _anoController,
                  decoration: const InputDecoration(
                    labelText: 'Ano de Publicação',
                  ),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  child: const Text('Adicionar Livro'),
                  onPressed: () {
                    final ano = int.tryParse(_anoController.text) ?? 0;
                    if (_tituloController.text.isEmpty || ano <= 0) return;

                    _adicionarNovoLivro(
                      _tituloController.text,
                      _autorController.text,
                      ano,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de Livros')),
      body: _livros.isEmpty
          ? const Center(child: Text('Nenhum livro cadastrado ainda!'))
          : ListView.builder(
              itemCount: _livros.length,
              itemBuilder: (ctx, index) {
                final livro = _livros[index];

                return Dismissible(
                  key: ValueKey(livro.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => _deletarLivro(livro.id),

                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: livro.lido
                            ? Colors.green
                            : Colors.blueGrey,
                        child: const Icon(Icons.book, color: Colors.white),
                      ),
                      title: Text(
                        livro.titulo,
                        style: TextStyle(
                          decoration: livro.lido
                              ? TextDecoration.lineThrough
                              : null,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('${livro.autor} (${livro.anoPublicacao})'),
                      trailing: Checkbox(
                        value: livro.lido,
                        onChanged: (_) => _toggleLido(livro.id),
                      ),
                      onTap: () => _toggleLido(livro.id),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _mostrarFormularioAdicao(context),
      ),
    );
  }
}
