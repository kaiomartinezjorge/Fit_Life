import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/atividade_controller.dart';
import '../models/atividade_model.dart';

class AtividadesView extends StatelessWidget {
  const AtividadesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AtividadeController>(context);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _abrirCadastro(context, controller),
                icon: const Icon(Icons.add),
                label: const Text('Nova atividade'),
              ),
            ),
          ),
          const TabBar(
            tabs: [
              Tab(text: 'Pendentes'),
              Tab(text: 'Concluidas'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ListaAtividades(
                  atividades: controller.pendentes,
                  concluida: false,
                ),
                ListaAtividades(
                  atividades: controller.concluidas,
                  concluida: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _abrirCadastro(
    BuildContext context,
    AtividadeController controller,
  ) async {
    String atividadeSelecionada = controller.tiposAtividade.first;
    TimeOfDay horarioSelecionado = const TimeOfDay(hour: 7, minute: 0);
    double duracao = 60;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final calorias = controller.estimarCalorias(
              atividadeSelecionada,
              duracao.round(),
            );

            return AlertDialog(
              title: const Text('Escolher atividade'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: atividadeSelecionada,
                      decoration: const InputDecoration(
                        labelText: 'Atividade',
                        border: OutlineInputBorder(),
                      ),
                      items: controller.tiposAtividade.map((atividade) {
                        return DropdownMenuItem(
                          value: atividade,
                          child: Text(atividade),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }

                        setModalState(() {
                          atividadeSelecionada = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final horario = await showTimePicker(
                          context: context,
                          initialTime: horarioSelecionado,
                        );

                        if (horario != null) {
                          setModalState(() {
                            horarioSelecionado = horario;
                          });
                        }
                      },
                      icon: const Icon(Icons.access_time),
                      label: Text(
                        'Horario: ${_formatarHorario(horarioSelecionado)}',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Duracao: ${duracao.round()} minutos'),
                    Slider(
                      min: 20,
                      max: 120,
                      divisions: 10,
                      value: duracao,
                      label: '${duracao.round()} min',
                      onChanged: (value) {
                        setModalState(() {
                          duracao = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Estimativa de calorias: $calorias kcal',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                FilledButton(
                  onPressed: () {
                    controller.adicionarAtividade(
                      tipo: atividadeSelecionada,
                      horarioInicial: horarioSelecionado,
                      duracaoMinutos: duracao.round(),
                    );

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Atividade adicionada com sucesso.'),
                      ),
                    );
                  },
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _formatarHorario(TimeOfDay horario) {
    final hora = horario.hour.toString().padLeft(2, '0');
    final minuto = horario.minute.toString().padLeft(2, '0');
    return '$hora:$minuto';
  }
}

class ListaAtividades extends StatelessWidget {
  const ListaAtividades({
    super.key,
    required this.atividades,
    required this.concluida,
  });

  final List<AtividadeModel> atividades;
  final bool concluida;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AtividadeController>(context, listen: false);

    if (atividades.isEmpty) {
      return Center(
        child: Text(
          concluida
              ? 'Nenhuma atividade concluida ainda.'
              : 'Nenhuma atividade pendente.',
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: atividades.length,
      itemBuilder: (context, index) {
        final atividade = atividades[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(atividade.icone),
            title: Text(atividade.nome),
            subtitle: Text(
              concluida && atividade.dataConclusao != null
                  ? 'Concluida em ${_formatarHora(atividade.dataConclusao!)}'
                  : '${atividade.horario} - ${atividade.calorias} kcal',
            ),
            trailing: IconButton(
              icon: Icon(
                concluida ? Icons.refresh : Icons.check_circle_outline,
              ),
              onPressed: () {
                if (concluida) {
                  controller.reabrirAtividade(atividade);
                } else {
                  controller.concluirAtividade(atividade);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${atividade.nome} concluida com sucesso.'),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  String _formatarHora(DateTime data) {
    final hora = data.hour.toString().padLeft(2, '0');
    final minuto = data.minute.toString().padLeft(2, '0');
    return '$hora:$minuto';
  }
}
