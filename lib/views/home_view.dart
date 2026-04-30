import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/configuracao_controller.dart';
import '../controllers/navegacao_controller.dart';
import 'atividades_view.dart';
import 'configuracoes_view.dart';
import 'dashboard_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final navegacaoController = Provider.of<NavegacaoController>(context);
    final telas = [
      const DashboardView(),
      const AtividadesView(),
      const ConfiguracoesView(),
    ];
    final indiceAtual = navegacaoController.indiceAtual;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          indiceAtual == 0
              ? 'Dashboard'
              : indiceAtual == 1
              ? 'Atividades'
              : 'Configuracoes',
        ),
      ),
      drawer: const DrawerMenu(),
      body: SafeArea(child: telas[indiceAtual]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: indiceAtual,
        onDestinationSelected: navegacaoController.alterarIndice,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.monitor_heart_outlined),
            selectedIcon: Icon(Icons.monitor_heart),
            label: 'Atividades',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Config.',
          ),
        ],
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final configuracaoController = Provider.of<ConfiguracaoController>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(configuracaoController.model.nomeUsuario),
            accountEmail: const Text('Fit Life'),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          _itemMenu(
            context,
            icone: Icons.dashboard,
            titulo: 'Dashboard',
            indice: 0,
          ),
          _itemMenu(
            context,
            icone: Icons.monitor_heart,
            titulo: 'Atividades',
            indice: 1,
          ),
          _itemMenu(
            context,
            icone: Icons.settings,
            titulo: 'Configuracoes',
            indice: 2,
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Ajuda'),
            subtitle: const Text('Como usar o aplicativo'),
            onTap: () {
              Navigator.of(context).pop();
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Ajuda'),
                    content: const Text(
                      'Use o menu ou a barra inferior para navegar entre as telas.\n\n'
                      'Na tela de atividades, toque em "Nova atividade" para escolher o exercicio, definir o horario e ver a estimativa de calorias.\n\n'
                      'No dashboard voce acompanha seu progresso. Em configuracoes voce pode alterar nome, tema e meta semanal.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Fechar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  ListTile _itemMenu(
    BuildContext context, {
    required IconData icone,
    required String titulo,
    required int indice,
  }) {
    return ListTile(
      leading: Icon(icone),
      title: Text(titulo),
      onTap: () {
        Provider.of<NavegacaoController>(
          context,
          listen: false,
        ).alterarIndice(indice);
        Navigator.of(context).pop();
      },
    );
  }
}
