import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/tarefa.dart';

class BancoDados {
  final CollectionReference<Map<String, dynamic>> _tarefas =
      FirebaseFirestore.instance.collection('tarefas');

  Future<void> cadastrarTarefa(String titulo) async {
    await _tarefas.add({
      'titulo': titulo,
      'concluida': false,
    });
  }

  Future<List<Tarefa>> consultarTarefas() async {
    final resultado = await _tarefas.get(
      const GetOptions(source: Source.serverAndCache),
    );
    return resultado.docs.map((doc) => Tarefa.fromDocument(doc)).toList();
  }

  Future<int> contarTarefas() async {
    final resultado = await _tarefas.get(
      const GetOptions(source: Source.serverAndCache),
    );
    return resultado.docs.length;
  }

  Future<void> atualizarConclusao(String id, bool concluida) async {
    await _tarefas.doc(id).update({'concluida': concluida});
  }

  Future<void> excluirTarefa(String id) async {
    await _tarefas.doc(id).delete();
  }
}
