# Minhas Tarefas

Aplicativo Flutter para cadastrar, listar, concluir e excluir tarefas. Os dados ficam em um banco SQLite local.

## Executar no Android/iOS

1. Instale o Flutter SDK.
2. Conecte um dispositivo ou inicie um emulador.
3. Na raiz do projeto, execute:

```sh
flutter pub get
flutter run
```

No Android e iOS, o arquivo do banco fica no armazenamento privado do aplicativo. Não é necessário criar o arquivo manualmente nem configurar servidor ou credenciais.

## Testar no Web Emulator do FlutLab

O projeto usa `sqflite_common_ffi_web` para executar SQLite no navegador. O suporte Web desse pacote é experimental; no navegador, os dados ficam no IndexedDB associados à origem/porta, não como `tarefas.db` no repositório.

Os arquivos `web/sqlite3.wasm` e `web/sqflite_sw.js` já estão incluídos. Se atualizar o pacote ou precisar gerá-los novamente, execute na raiz do projeto:

```sh
dart run sqflite_common_ffi_web:setup
```

Depois, mantenha os dois arquivos na pasta `web/` ao importar ou atualizar o projeto no FlutLab e escolha **web-emulator** para compilar/abrir a versão Web. Use sempre a mesma origem e porta para manter o armazenamento local do navegador.

## Banco de dados e funcionalidades

Na primeira execução, o app cria a tabela `tarefas` com:

- `id`: inteiro, chave primária e autoincremental;
- `titulo`: texto obrigatório;
- `concluida`: inteiro (`0` ou `1`), padrão `0`.

O app recarrega a lista após adicionar, concluir ou excluir. O formulário espera a gravação antes de voltar à lista e permanece aberto se ocorrer erro. Os dados são locais e não sincronizam entre navegador, emulador e dispositivo.
