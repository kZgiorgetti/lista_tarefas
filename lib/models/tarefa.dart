import 'package:cloud_firestore/cloud_firestore.dart';

class Tarefa {
  final String id;
  final String titulo;
  final bool concluida;

  Tarefa({
    required this.id,
    required this.titulo,
    required this.concluida,
  });

  factory Tarefa.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final dados = doc.data() ?? {};
    return Tarefa(
      id: doc.id,
      titulo: dados['titulo'] ?? '',
      concluida: dados['concluida'] ?? false,
    );
  }
}
