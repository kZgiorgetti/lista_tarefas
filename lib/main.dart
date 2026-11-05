import 'package:flutter/material.dart';

import 'services/configurar_banco.dart' as banco;
import 'screens/inicio_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await banco.configurar();

  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhas Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: const Color(0xFFF4F9F8),
        useMaterial3: true,
      ),
      home: const InicioScreen(),
    );
  }
}
