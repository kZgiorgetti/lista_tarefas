import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/inicio_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC-A6-OJlaWljoBDGFyiX4B_JLm-mhyKXE",
      appId: "1:951048712364:web:f0ca5500b29a4acc0f2f09",
      messagingSenderId: "951048712364",
      projectId: "lista-tarefas-a90e6",
    ),
  );

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
