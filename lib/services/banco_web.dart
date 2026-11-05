import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

Future<void> configurar() async {
  databaseFactory = databaseFactoryFfiWeb;
}

Future<String> caminho(String nome) async => nome;
