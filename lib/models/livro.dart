class Livro {
  final String id;
  String titulo;
  String autor;
  int anoPublicacao;
  bool lido;

  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.anoPublicacao,
    this.lido = false,
  });
}
