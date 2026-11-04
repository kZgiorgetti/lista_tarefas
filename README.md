# Minhas Tarefas — Lista de tarefas com Flutter e Firebase

Projeto acadêmico simples, feito em **Dart e Flutter**, para cadastrar, visualizar, concluir e excluir tarefas pessoais. Os dados ficam salvos no **Firebase Cloud Firestore**.

> **Aviso:** este código foi escrito e revisado, mas **não foi executado** em um dispositivo ou no FlutLab durante a criação. Pode ser necessário ajustar pequenos detalhes (como a versão das dependências) conforme o ambiente.

## 1. Funcionalidades

- **Início:** nome do app, mensagem de boas-vindas, quantidade de tarefas e botão para abrir a lista.
- **Lista de tarefas:** mostra as tarefas, permite marcar como concluída, excluir e abrir a tela de nova tarefa. Se não houver tarefas, aparece uma mensagem simples.
- **Adicionar tarefa:** campo de texto e botão de salvar. Não aceita título vazio. Ao salvar, volta para a lista já atualizada.

## 2. Tecnologias utilizadas

- Dart e Flutter (componentes nativos, `setState`, `Navigator.push` e `Navigator.pop`)
- Firebase Core (`firebase_core`)
- Cloud Firestore (`cloud_firestore`)

## 3. Estrutura de pastas

```text
lib/
├── main.dart
├── models/
│   └── tarefa.dart
├── services/
│   └── banco_dados.dart
└── screens/
    ├── inicio_screen.dart
    ├── lista_tarefas_screen.dart
    └── adicionar_tarefa_screen.dart 

pubspec.yaml
README.md
```

## 4. Pré-requisitos

- Conta gratuita no [FlutLab.io](https://flutlab.io)
- Conta Google (para usar o [Firebase Console](https://console.firebase.google.com))
- Conexão com a internet

## 5. Como abrir o projeto no FlutLab.io

1. Entre no FlutLab.io e crie um novo projeto Flutter (ou abra um projeto existente).
2. Substitua o conteúdo do `pubspec.yaml` pelo deste projeto.
3. Dentro da pasta `lib/`, crie as pastas `models`, `services` e `screens`.
4. Crie cada arquivo `.dart` com o mesmo nome e caminho mostrados na estrutura acima e cole o código correspondente.
5. Se o projeto criado já tiver um arquivo de teste em `test/` que faça referência ao app de exemplo (`MyApp`), apague esse arquivo para evitar erros.

Os nomes exatos de menus do FlutLab podem mudar com o tempo. Se algo estiver diferente, procure a opção equivalente no editor.

## 6. Como configurar um projeto Firebase

1. Acesse o [Firebase Console](https://console.firebase.google.com) e clique em **Criar um projeto** (ou **Adicionar projeto**).
2. Dê um nome (por exemplo, `lista-tarefas`) e conclua a criação. Pode desativar o Google Analytics, pois não é necessário.
3. Na página inicial do projeto, clique em **Adicionar app** e escolha a plataforma que você vai usar para executar no FlutLab:
   - **Web** (ícone `</>`) — normalmente a opção mais simples para testar no navegador.
   - **Android** — use se for executar em emulador/dispositivo Android.
4. Registre o app com um apelido. Para Android, será pedido o **nome do pacote**: ele está no arquivo `android/app/build.gradle` (campo `applicationId`) ou no `AndroidManifest.xml` do seu projeto no FlutLab. Use exatamente esse nome.
5. Depois de registrar, o Firebase mostra os valores de configuração (`apiKey`, `appId`, `messagingSenderId`, `projectId`). Você também encontra esses valores em **Configurações do projeto** (engrenagem) → **Geral** → **Seus apps**.

## 7. Como habilitar o Cloud Firestore

1. No menu lateral do Firebase Console, abra **Criação** → **Firestore Database**.
2. Clique em **Criar banco de dados**.
3. Escolha a localização mais próxima de você e avance.
4. Escolha o **modo de teste** (permite leitura e escrita temporariamente). Esse modo é só para estudo e expira depois de alguns dias; não use em um app real.
5. Clique em **Criar**. Não precisa criar a coleção manualmente: o app cria a coleção `tarefas` ao salvar a primeira tarefa.

Se aparecer erro de permissão depois, abra a aba **Regras** do Firestore e confira se o modo de teste ainda está válido.

## 8. Como configurar as dependências e a conexão com o banco de dados

**Dependências:** já estão no `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.32.0
  cloud_firestore: ^4.17.5
```

Depois de colar o arquivo, execute **Pub get** no FlutLab (ou a opção equivalente de baixar dependências). Se der erro de versão incompatível com o Flutter do FlutLab, tente versões `firebase_core` e `cloud_firestore` mais antigas ou mais novas, conforme a mensagem de erro.

**Conexão:** para ficar simples, o app **não usa** o `firebase_options.dart` gerado pela FlutterFire CLI (que depende de ferramentas de linha de comando). Em vez disso, os dados do Firebase são colocados direto no `main.dart`:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: 'COLE_AQUI_SUA_API_KEY',
    appId: 'COLE_AQUI_SEU_APP_ID',
    messagingSenderId: 'COLE_AQUI_SEU_MESSAGING_SENDER_ID',
    projectId: 'COLE_AQUI_SEU_PROJECT_ID',
  ),
);
```

Substitua cada texto entre aspas pelos valores do passo 5 da seção 6. Use os valores do app **da mesma plataforma** que você vai executar (Web ou Android), pois o `appId` é diferente em cada uma.

**Arquivos de configuração:** com este método, o `google-services.json` não é obrigatório. Ele só seria necessário se você preferisse o método padrão do Android (colocar o arquivo em `android/app/` e configurar o plugin do Google Services no Gradle). Se escolher esse caminho, siga a documentação oficial do Firebase e verifique se o plano/ambiente do FlutLab permite editar os arquivos da pasta `android`. Se não permitir, use o método deste README ou execute o projeto no seu computador com o Flutter instalado.

## 9. Como executar o aplicativo

1. Confira se todos os arquivos estão no lugar e se os dados do Firebase foram preenchidos no `main.dart`.
2. Clique em **Run** (ou equivalente) no FlutLab e escolha a plataforma (Web ou Android) compatível com o app registrado no Firebase.
3. Aguarde a compilação. A tela de início deve aparecer.

## 10. Como testar

1. **Cadastro:** na tela de início, clique em **Ver lista de tarefas**, depois em **Adicionar tarefa**, digite um título e clique em **Salvar tarefa**. Você volta para a lista e a tarefa aparece.
2. **Título vazio:** tente salvar sem digitar nada. Deve aparecer a mensagem "Digite o título da tarefa."
3. **Consulta:** a lista mostra as tarefas salvas. No Firebase Console, em **Firestore Database**, você vê a coleção `tarefas` com os campos `titulo` e `concluida`.
4. **Conclusão:** marque a caixa de seleção de uma tarefa. O título fica riscado e o campo `concluida` muda para `true` no Firestore.
5. **Exclusão:** clique no ícone de lixeira. A tarefa some da lista e do Firestore.
6. **Contagem:** volte para o início e veja se a quantidade de tarefas foi atualizada.
7. **Lista vazia:** exclua todas as tarefas e confira a mensagem "Nenhuma tarefa cadastrada."

## 11. Como funcionam `async` e `await`

Acessar o banco de dados leva um tempo, pois os dados vêm da internet. Se o app ficasse esperando parado, a tela travaria.

- `Future` representa um resultado que **ainda vai chegar**. Exemplo: `Future<List<Tarefa>>` é "uma lista de tarefas que vai chegar".
- `async` marca uma função que pode esperar por um `Future`.
- `await` diz: "espere este resultado chegar antes de ir para a próxima linha", sem travar a tela.

Exemplo do projeto:

```dart
Future<void> _carregarTarefas() async {
  final lista = await _banco.consultarTarefas();
  setState(() {
    _tarefas = lista;
  });
}
```

O app pede as tarefas ao banco, **espera** a resposta e só então chama `setState` para atualizar a tela. O bloco `try/catch` captura erros (por exemplo, falta de internet) e mostra uma mensagem amigável.

## 12. Problemas comuns e possíveis soluções

| Problema                                     | Possível solução                                                                                                         |
| -------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| Erro ao baixar dependências                  | Confira o `pubspec.yaml` (espaços e recuos) e rode o **Pub get** de novo. Ajuste as versões se houver incompatibilidade. |
| Erro de `apiKey` ou `appId` inválido         | Confira se copiou os valores corretos e se são da mesma plataforma que está executando (Web ou Android).                 |
| "Missing or insufficient permissions"        | As regras do Firestore estão bloqueando. Verifique se o banco está em modo de teste e dentro do prazo.                   |
| Mensagem de erro na tela inicial ou na lista | Verifique a internet, os dados do Firebase no `main.dart` e se o Firestore foi criado.                                   |
| Tarefa não aparece depois de salvar          | Confira no Firebase Console se o documento foi criado na coleção `tarefas`. Se sim, volte e abra a lista novamente.      |
| Erro de import                               | Confira se os nomes e pastas dos arquivos estão exatamente como na estrutura do projeto.                                 |
| Erro no arquivo de teste                     | Apague o arquivo `test/widget_test.dart` do projeto de exemplo, se existir.                                              |
| FlutLab não consegue compilar com Firebase   | Execute o projeto no seu computador com Flutter instalado, usando os mesmos arquivos.                                    |
