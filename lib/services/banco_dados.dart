import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/tarefa.dart';

class BancoDados {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> cadastrarTarefa(String titulo) async {
    await _supabase.from('tarefas').insert({'titulo': titulo});
  }

  Future<List<Tarefa>> consultarTarefas() async {
    final resultado = await _supabase
        .from('tarefas')
        .select('id, titulo, concluida')
        .order('id');
    return resultado.map((dados) => Tarefa.fromMap(dados)).toList();
  }

  Future<int> contarTarefas() async {
    final resultado = await _supabase.from('tarefas').select('id');
    return resultado.length;
  }

  Future<void> atualizarConclusao(int id, bool concluida) async {
    await _supabase
        .from('tarefas')
        .update({'concluida': concluida})
        .eq('id', id);
  }

  Future<void> excluirTarefa(int id) async {
    await _supabase.from('tarefas').delete().eq('id', id);
  }
}
