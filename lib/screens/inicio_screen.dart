import 'package:flutter/material.dart';

import '../services/banco_dados.dart';
import 'lista_tarefas_screen.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  final BancoDados _banco = BancoDados();
  int _quantidade = 0;
  bool _carregando = true;
  String _erro = '';

  @override
  void initState() {
    super.initState();
    _carregarQuantidade();
  }

  Future<void> _carregarQuantidade() async {
    try {
      final total = await _banco.contarTarefas();
      if (!mounted) return;
      setState(() {
        _quantidade = total;
        _erro = '';
        _carregando = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _erro = 'Não foi possível carregar as tarefas. Tente novamente.';
        _carregando = false;
      });
    }
  }

  Future<void> _abrirLista() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListaTarefasScreen()),
    );
    if (mounted) _carregarQuantidade();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Tarefas')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.checklist, size: 80, color: Colors.teal),
              const SizedBox(height: 16),
              const Text(
                'Minhas Tarefas',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bem-vindo! Organize suas tarefas do dia a dia.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              if (_carregando)
                const CircularProgressIndicator()
              else if (_erro.isNotEmpty)
                Text(
                  _erro,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                )
              else
                Text(
                  'Tarefas cadastradas: $_quantidade',
                  style: const TextStyle(fontSize: 18),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _abrirLista,
                child: const Text('Ver lista de tarefas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
