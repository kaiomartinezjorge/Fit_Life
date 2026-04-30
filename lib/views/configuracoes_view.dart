import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/atividade_controller.dart';
import '../controllers/configuracao_controller.dart';

class ConfiguracoesView extends StatelessWidget {
  const ConfiguracoesView({super.key});

  @override
  Widget build(BuildContext context) {
    final configuracaoController = Provider.of<ConfiguracaoController>(context);
    final configuracao = configuracaoController.model;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextFormField(
          initialValue: configuracao.nomeUsuario,
          decoration: const InputDecoration(
            labelText: 'Nome do usuario',
            border: OutlineInputBorder(),
          ),
          onChanged: configuracaoController.atualizarNome,
        ),
        const SizedBox(height: 20),
        Card(
          child: SwitchListTile(
            title: const Text('Tema escuro'),
            subtitle: const Text('Ative para mudar o visual do app'),
            value: configuracao.temaEscuro,
            onChanged: configuracaoController.alternarTema,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Meta semanal: ${configuracao.metaSemanal} atividades'),
                Slider(
                  min: 1,
                  max: 14,
                  divisions: 13,
                  value: configuracao.metaSemanal.toDouble(),
                  label: '${configuracao.metaSemanal}',
                  onChanged: (value) {
                    configuracaoController.atualizarMeta(value.round());
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.tonal(
          onPressed: () => _confirmarReset(context),
          child: const Text('Resetar progresso'),
        ),
      ],
    );
  }

  Future<void> _confirmarReset(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar reset'),
          content: const Text('Deseja resetar todas as atividades concluidas?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Resetar'),
            ),
          ],
        );
      },
    );

    if (confirmar == true && context.mounted) {
      Provider.of<AtividadeController>(
        context,
        listen: false,
      ).resetarProgresso();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Progresso resetado com sucesso.')),
      );
    }
  }
}
