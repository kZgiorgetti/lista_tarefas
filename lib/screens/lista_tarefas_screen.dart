import 'package:flutter/material.dart';

import '../models/tarefa.dart';
import '../services/banco_dados.dart';
import 'adicionar_tarefa_screen.dart';

class ListaTarefasScreen extends StatefulWidget {
  const ListaTarefasScreen({super.key});

  @override
  State<ListaTarefasScreen> createState() => _ListaTarefasScreenState();
}

class _ListaTarefasScreenState extends State<ListaTarefasScreen> {
  final BancoDados _banco = BancoDados();
  List<Tarefa> _tarefas = [];
  bool _carregando = true;
  String? _erroCarregamento;

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  void _mostrarMensagem(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  Future<void> _carregarTarefas() async {
    if (mounted) {
      setState(() {
        _carregando = true;
      });
    }
    try {
      final lista = await _banco.consultarTarefas();
      if (!mounted) return;
      setState(() {
        _tarefas = lista;
        _carregando = false;
        _erroCarregamento = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _carregando = false;
        _erroCarregamento = 'Erro ao carregar as tarefas. Tente novamente.';
      });
      _mostrarMensagem('Erro ao carregar as tarefas. Tente novamente.');
    }
  }

  Future<void> _alterarConclusao(Tarefa tarefa, bool? valor) async {
    try {
      await _banco.atualizarConclusao(tarefa.id, valor ?? false);
      await _carregarTarefas();
    } catch (e) {
      _mostrarMensagem('Erro ao atualizar a tarefa.');
    }
  }

  Future<void> _excluirTarefa(Tarefa tarefa) async {
    try {
      await _banco.excluirTarefa(tarefa.id);
      await _carregarTarefas();
      _mostrarMensagem('Tarefa excluída.');
    } catch (e) {
      _mostrarMensagem('Erro ao excluir a tarefa.');
    }
  }

  Future<void> _abrirAdicionar() async {
    final salvou = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdicionarTarefaScreen()),
    );
    if (!mounted || salvou != true) return;
    await _carregarTarefas();
  }

  Widget _construirLista() {
    if (_carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_erroCarregamento != null && _tarefas.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_erroCarregamento!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _carregarTarefas,
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }

    if (_tarefas.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma tarefa cadastrada.',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _tarefas.length,
      itemBuilder: (context, indice) {
        final tarefa = _tarefas[indice];
        return Card(
          child: ListTile(
            leading: Checkbox(
              value: tarefa.concluida,
              onChanged: (valor) => _alterarConclusao(tarefa, valor),
            ),
            title: Text(
              tarefa.titulo,
              style: TextStyle(
                decoration:
                    tarefa.concluida ? TextDecoration.lineThrough : null,
                color: tarefa.concluida ? Colors.grey : Colors.black,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Excluir tarefa',
              onPressed: () => _excluirTarefa(tarefa),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Tarefas')),
      body: _construirLista(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _abrirAdicionar,
        icon: const Icon(Icons.add),
        label: const Text('Adicionar tarefa'),
      ),
    );
  }
}
