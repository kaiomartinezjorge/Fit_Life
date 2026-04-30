import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/atividade_controller.dart';
import '../controllers/configuracao_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final atividadeController = Provider.of<AtividadeController>(context);
    final configuracaoController = Provider.of<ConfiguracaoController>(context);
    final metaSemanal = configuracaoController.model.metaSemanal;
    final progresso = (atividadeController.totalConcluidas / metaSemanal).clamp(
      0.0,
      1.0,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 500 ? 4 : 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: [
              _cardMetrica(
                titulo: 'Concluidas',
                valor: '${atividadeController.totalConcluidas}',
              ),
              _cardMetrica(
                titulo: 'Pendentes',
                valor: '${atividadeController.totalPendentes}',
              ),
              _cardMetrica(
                titulo: 'Calorias',
                valor: '${atividadeController.caloriasConcluidas} kcal',
              ),
              _cardMetrica(
                titulo: 'Tempo total',
                valor: atividadeController.tempoTotalFormatado,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Meta semanal'),
                      Text('${(progresso * 100).round()}%'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(value: progresso),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              title: const Text('Nivel de atividade'),
              subtitle: Text(
                atividadeController.nivelAtividade,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardMetrica({required String titulo, required String valor}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(titulo),
            const SizedBox(height: 6),
            Text(
              valor,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
