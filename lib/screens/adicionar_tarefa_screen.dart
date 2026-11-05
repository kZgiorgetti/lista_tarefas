import 'package:flutter/material.dart';

import '../services/banco_dados.dart';

class AdicionarTarefaScreen extends StatefulWidget {
  const AdicionarTarefaScreen({super.key});

  @override
  State<AdicionarTarefaScreen> createState() => _AdicionarTarefaScreenState();
}

class _AdicionarTarefaScreenState extends State<AdicionarTarefaScreen> {
  final BancoDados _banco = BancoDados();
  final TextEditingController _controlador = TextEditingController();
  String _erro = '';
  bool _salvando = false;

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  Future<void> _salvarTarefa() async {
    if (_salvando) return;

    final titulo = _controlador.text.trim();

    if (titulo.isEmpty) {
      setState(() {
        _erro = 'Digite o título da tarefa.';
      });
      return;
    }

    setState(() {
      _erro = '';
      _salvando = true;
    });

    try {
      await _banco.cadastrarTarefa(titulo);
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _erro = 'Não foi possível salvar a tarefa. Tente novamente.';
        _salvando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controlador,
              decoration: InputDecoration(
                labelText: 'Título da tarefa',
                border: const OutlineInputBorder(),
                errorText: _erro.isEmpty ? null : _erro,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _salvando ? null : _salvarTarefa,
              child: Text(_salvando ? 'Salvando...' : 'Salvar tarefa'),
            ),
          ],
        ),
      ),
    );
  }
}
