class Tarefa {
  final int id;
  final String titulo;
  final bool concluida;

  Tarefa({
    required this.id,
    required this.titulo,
    required this.concluida,
  });

  factory Tarefa.fromMap(Map<String, dynamic> dados) {
    return Tarefa(
      id: (dados['id'] as num).toInt(),
      titulo: dados['titulo'] as String? ?? '',
      concluida: dados['concluida'] as bool? ?? false,
    );
  }
}
