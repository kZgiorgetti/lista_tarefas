# Minhas Tarefas — Flutter e SQLite

Aplicativo Flutter para cadastrar, listar, concluir e excluir tarefas usando um banco SQLite local.

## Como executar

Instale o Flutter SDK, conecte um dispositivo ou inicie um emulador Android e execute na pasta do projeto:

```sh
flutter pub get
flutter run
```

Não é preciso criar conta, configurar servidor ou preencher credenciais. O app cria o banco e a tabela automaticamente na primeira execução.

## Banco de dados

A tabela `tarefas` contém `id` (chave primária autoincremental), `titulo` (texto obrigatório) e `concluida` (0 ou 1, com padrão 0).

No Android e iOS, o arquivo `tarefas.db` fica no armazenamento privado do app. Se o projeto receber suporte desktop, o código usa a pasta de trabalho atual para o arquivo durante o desenvolvimento; em geral, é a raiz do repositório. Esses dados são locais e não sincronizam entre dispositivos.

A lista é recarregada após adicionar, concluir ou excluir uma tarefa. O formulário aguarda a gravação antes de voltar à lista e permanece aberto se houver erro.
