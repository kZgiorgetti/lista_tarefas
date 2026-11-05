# Minhas Tarefas

Aplicativo feito com Flutter para cadastrar, listar, concluir e excluir tarefas. Os dados são guardados localmente usando SQLite.

## Requisitos

- Flutter SDK instalado.
- Um emulador Android/iOS iniciado ou um dispositivo conectado.

## Executar o aplicativo

No terminal, abra a pasta do projeto e rode:

```sh
flutter pub get
flutter run
```

Se houver mais de um dispositivo, veja os disponíveis com `flutter devices` e escolha um usando `flutter run -d ID_DO_DISPOSITIVO`.

Este projeto tem configuração para Android e iOS. Embora também exista uma pasta `web`, o SQLite usado pelo app não funciona no navegador. O projeto ainda não tem a plataforma Windows configurada.

## Banco de dados

Na primeira execução, o app cria automaticamente o banco `tarefas.db` e a tabela `tarefas`.

A tabela contém:

- `id`: número inteiro, chave primária e gerado automaticamente;
- `titulo`: texto obrigatório;
- `concluida`: número (`0` para não concluída e `1` para concluída), padrão `0`.

No Android e iOS, o arquivo do banco fica no armazenamento privado do aplicativo, não na pasta do repositório. Não é necessário criar o arquivo manualmente nem configurar servidor, conta ou credenciais. Os dados ficam no dispositivo e não são sincronizados com outros aparelhos.

## Uso

Na tela inicial, abra a lista para visualizar as tarefas. Use **Adicionar tarefa** para cadastrar uma tarefa; o título não pode ficar vazio. O app espera a gravação no banco antes de voltar à lista. Na lista, marque a caixa para concluir ou use o ícone de lixeira para excluir. A lista é atualizada depois de cada operação.
