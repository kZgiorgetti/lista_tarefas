import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

import '../models/tarefa.dart';

class BancoDados {
  static const String _nomeBanco = 'tarefas.db';
  static const String _nomeTabela = 'tarefas';
  static Database? _banco;

  Future<Database> get _database async {
    if (_banco != null) return _banco!;

    final usarArquivoNoRepositorio = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.linux ||
            defaultTargetPlatform == TargetPlatform.macOS);
    final caminho = usarArquivoNoRepositorio
        ? path.join(Directory.current.path, _nomeBanco)
        : path.join(await getDatabasesPath(), _nomeBanco);
    _banco = await openDatabase(
      caminho,
      version: 1,
      onCreate: (db, versao) async {
        await db.execute('''
          CREATE TABLE $_nomeTabela (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT NOT NULL,
            concluida INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
    return _banco!;
  }

  Future<void> cadastrarTarefa(String titulo) async {
    await (await _database).insert(_nomeTabela, {'titulo': titulo});
  }

  Future<List<Tarefa>> consultarTarefas() async {
    final resultado = await (await _database).query(
      _nomeTabela,
      orderBy: 'id ASC',
    );
    return resultado.map(Tarefa.fromMap).toList();
  }

  Future<int> contarTarefas() async {
    final resultado = await (await _database).rawQuery(
      'SELECT COUNT(*) AS total FROM $_nomeTabela',
    );
    return Sqflite.firstIntValue(resultado) ?? 0;
  }

  Future<void> atualizarConclusao(int id, bool concluida) async {
    await (await _database).update(
      _nomeTabela,
      {'concluida': concluida ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> excluirTarefa(int id) async {
    await (await _database).delete(
      _nomeTabela,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
