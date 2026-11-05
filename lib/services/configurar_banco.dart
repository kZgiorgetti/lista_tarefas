import 'banco_io.dart'
    if (dart.library.js_interop) 'banco_web.dart' as plataforma;

Future<void> configurar() => plataforma.configurar();

Future<String> caminho(String nome) => plataforma.caminho(nome);
