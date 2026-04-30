# Documento de Requisitos do Software (SRS)

## Fit Life - App de Saude e Atividades Fisicas

**Padrao:** ISO/IEC/IEEE 29148:2018  
**Versao:** 1.0.0  
**Data:** 2026-04-30  
**Autores:** Equipe Fit Life

---

## 1. Introducao

### 1.1 Objetivo

Este documento explica o que o app **Fit Life** deve fazer. Ele serve para:

- mostrar as funcoes esperadas do aplicativo;
- alinhar o entendimento da equipe;
- ajudar no desenvolvimento, nos testes e na avaliacao do projeto.

### 1.2 Escopo

O app vai permitir:

- registrar e acompanhar atividades fisicas;
- organizar atividades pendentes e concluidas;
- mostrar resumo de desempenho no Dashboard;
- mudar preferencias do usuario, como tema, meta e nome.

Tecnologias usadas:

- **Flutter**
- **Dart**
- **MVC**
- **Provider**
- **Material Design 3**

### 1.3 Termos

| Termo | Significado |
|-------|-------------|
| Atividade | Exercicio registrado no app |
| Pendente | Atividade ainda nao feita |
| Concluida | Atividade marcada como feita |
| Meta semanal | Quantidade de atividades desejada na semana |
| Dashboard | Tela com resumo do desempenho |
| Model | Parte dos dados |
| View | Parte da interface |
| Controller | Parte que controla a logica |

Siglas:

- **SRS** - Documento de requisitos
- **MVC** - Model, View, Controller
- **RF** - Requisito funcional
- **RNF** - Requisito nao funcional

### 1.4 Organizacao do documento

Este documento segue uma estrutura simples inspirada na **ISO/IEC/IEEE 29148:2018**:

- **Secao 1:** introducao, objetivo, escopo e termos;
- **Secao 2:** visao geral do sistema;
- **Secao 3:** requisitos funcionais e nao funcionais;
- **Secao 4:** regras de negocio;
- **Secao 5:** estrutura do sistema;
- **Secao 6:** riscos;
- **Secao 7:** controle de versoes.

---

## 2. Visao Geral do Sistema

O **Fit Life** e um app mobile sem backend nesta versao. Ele usa arquitetura **MVC**, com **Provider** para atualizar a interface quando houver mudanca de estado.

### Funcoes principais

- mostrar tela inicial;
- listar atividades pendentes;
- marcar atividades como concluidas;
- mover atividades entre listas;
- mostrar metricas no Dashboard;
- permitir mudancas nas configuracoes.

### Usuarios

- **Usuario final:** usa o app para acompanhar exercicios;
- **Desenvolvedor:** cria e mantem o projeto em Flutter;
- **Professor/Avaliador:** verifica se o projeto atende aos requisitos.

### Relacao com outros sistemas

Nesta versao, o app funciona de forma independente, sem conexao com banco de dados externo ou servidor.

### Ambiente

- Android 6.0+ ou iOS 13+;
- Flutter 3.x com Dart;
- telas de celular entre 360dp e 428dp.

### Restricoes

- sem banco de dados externo;
- dados guardados apenas em memoria;
- uso obrigatorio de MVC;
- Provider usado para ligar Controllers e Views;
- login opcional e apenas simulado.

### Suposicoes

- o usuario sabe usar apps basicos;
- o numero de atividades por sessao sera pequeno;
- o ambiente de desenvolvimento ja tem Flutter configurado.

---

## 3. Requisitos do Sistema

### 3.1 Requisitos Funcionais

#### RF-001: Tela inicial

O app deve mostrar uma tela de abertura com o nome **Fit Life**, uma frase motivacional, imagem ou icone fitness e um botao **Comecar**.

#### RF-002: AppBar e Drawer

O app deve ter AppBar com titulo e um menu lateral com:

- Dashboard
- Atividades
- Configuracoes
- Ajuda

#### RF-003: Navegacao inferior

O app deve ter uma barra inferior com:

- Dashboard
- Atividades
- Configuracoes

#### RF-004: Lista de atividades pendentes

O app deve mostrar atividades pendentes, como:

- Caminhada
- Corrida
- Musculacao
- Alongamento
- Yoga

Cada item deve mostrar nome, icone, tempo estimado e calorias.

#### RF-005: Concluir atividade

O usuario deve poder marcar uma atividade como concluida. Quando isso acontecer:

- ela sai da lista de pendentes;
- vai para a lista de concluidas;
- o app mostra uma confirmacao visual.

#### RF-006: Lista de atividades concluidas

O app deve mostrar as atividades ja feitas, com nome, icone e horario da conclusao.

#### RF-007: Dashboard

O Dashboard deve mostrar:

- atividades concluidas;
- atividades pendentes;
- calorias estimadas;
- tempo total;
- progresso da meta semanal;
- nivel de atividade.

#### RF-008: Configuracoes

O usuario deve poder:

- trocar entre tema claro e escuro;
- mudar o nome;
- mudar a meta semanal;
- resetar o progresso com confirmacao.

### 3.2 Requisitos Nao Funcionais

#### RNF-001: Usabilidade

- interface simples e facil de usar;
- respostas visuais rapidas;
- suporte a tema claro e escuro.

#### RNF-002: Desempenho

- abrir em ate 3 segundos;
- trocar de tela em menos de 300ms;
- manter navegacao fluida.

#### RNF-003: Arquitetura

- **Model:** guarda os dados;
- **View:** mostra a interface;
- **Controller:** controla a logica;
- a View nao deve mexer direto nos dados.

#### RNF-004: Confiabilidade

- evitar erros durante o uso normal;
- manter o projeto sem avisos importantes;
- manter o codigo formatado.

#### RNF-005: Manutencao

- nomes organizados e padronizados;
- separacao por pastas `models/`, `controllers/` e `views/`;
- README com instrucoes do projeto.

---

## 4. Regras de Negocio

- a quantidade de atividades concluidas nao pode ser negativa;
- a meta semanal deve ficar entre 1 e 14;
- uma atividade nao pode estar em pendentes e concluidas ao mesmo tempo;
- o progresso da meta vai ate 100%;
- cada atividade concluida deve guardar data e hora;
- resetar progresso precisa de confirmacao;
- a troca de tema deve acontecer na hora;
- a logica deve ficar no Controller.

---

## 5. Estrutura do Sistema

### Estrutura completa

```text
lib/
|-- main.dart
|
|-- models/
|   |-- atividade_model.dart
|   |-- configuracao_model.dart
|   `-- navegacao_model.dart
|
|-- controllers/
|   |-- atividade_controller.dart
|   |-- dashboard_controller.dart
|   |-- configuracao_controller.dart
|   `-- navegacao_controller.dart
|
|-- views/
|   |-- splash_view.dart
|   |-- home_view.dart
|   |-- atividades_view.dart
|   |-- dashboard_view.dart
|   `-- configuracoes_view.dart
|
|-- widgets/
|   |-- atividade_card.dart
|   |-- metrica_card.dart
|   `-- drawer_menu.dart
|
`-- constants/
    |-- app_colors.dart
    |-- app_strings.dart
    `-- atividades_iniciais.dart
```

### Descricao da estrutura

- `main.dart`: ponto de entrada do aplicativo;
- `models/`: guarda os dados do sistema;
- `controllers/`: guarda a logica e controla as acoes;
- `views/`: guarda as telas e a interface;
- `widgets/`: guarda componentes reutilizaveis;
- `constants/`: guarda valores fixos e configuracoes gerais.

### Organizacao MVC

- **Model:** representa os dados do app;
- **Controller:** aplica as regras e atualiza o estado;
- **View:** mostra as telas e recebe a interacao do usuario.

### Classes que devem ser feitas

#### Classes Model

| Classe | Funcionalidade |
|--------|----------------|
| `AtividadeModel` | guardar os dados de cada atividade, como nome, icone, tempo, calorias e status |
| `ConfiguracaoModel` | guardar dados de configuracao, como tema, nome do usuario e meta semanal |
| `NavegacaoModel` | guardar o indice da tela atual na navegacao |

#### Classes Controller

| Classe | Funcionalidade |
|--------|----------------|
| `AtividadeController` | controlar as listas de atividades pendentes e concluidas, concluir atividade, desfazer e resetar progresso |
| `DashboardController` | calcular e atualizar as metricas mostradas no Dashboard |
| `ConfiguracaoController` | alterar tema, nome do usuario e meta semanal |
| `NavegacaoController` | controlar a troca de telas no menu lateral e na barra inferior |
| `SplashController` | controlar a tela inicial e o envio do usuario para a tela principal |

#### Classes View

| Classe | Funcionalidade |
|--------|----------------|
| `SplashView` | mostrar a tela inicial do aplicativo |
| `HomeView` | mostrar a estrutura principal com AppBar, Drawer e navegacao |
| `AtividadesView` | mostrar as listas de atividades pendentes e concluidas |
| `DashboardView` | mostrar os cards e dados de desempenho |
| `ConfiguracoesView` | mostrar as opcoes de configuracao do usuario |

#### Classes Widget

| Classe | Funcionalidade |
|--------|----------------|
| `AtividadeCard` | mostrar cada atividade em formato reutilizavel |
| `MetricaCard` | mostrar cada metrica do Dashboard em formato de card |
| `DrawerMenu` | mostrar o menu lateral de navegacao |

#### Arquivos de apoio

| Arquivo | Funcionalidade |
|--------|----------------|
| `main.dart` | iniciar o app e registrar os controllers |
| `app_colors.dart` | guardar as cores usadas no app |
| `app_strings.dart` | guardar textos e mensagens padrao |
| `atividades_iniciais.dart` | guardar a lista inicial de atividades do sistema |

---

## 6. Riscos

- colocar logica na View em vez do Controller;
- perder dados ao fechar o app;
- acoplar View e Model de forma errada;
- problema de layout em telas muito pequenas;
- queda de desempenho com listas grandes.


## Link Figma ([Projeto Figma](https://www.figma.com/design/hgyxLJ7bveR94FMbcUqJDQ/Sem-t%C3%ADtulo?node-id=0-1&t=AyV27N3VQ1QdoSX6-1))