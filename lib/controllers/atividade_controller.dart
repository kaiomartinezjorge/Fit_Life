import 'package:flutter/material.dart';

import '../models/atividade_model.dart';

class AtividadeController extends ChangeNotifier {
  final List<String> tiposAtividade = [
    'Corrida',
    'Caminhada',
    'Musculacao',
    'Alongamento',
    'Yoga',
  ];

  final List<AtividadeModel> _atividades = [];

  List<AtividadeModel> get pendentes =>
      _atividades.where((atividade) => !atividade.concluida).toList();

  List<AtividadeModel> get concluidas =>
      _atividades.where((atividade) => atividade.concluida).toList();

  int get totalConcluidas => concluidas.length;

  int get totalPendentes => pendentes.length;

  int get caloriasConcluidas =>
      concluidas.fold(0, (total, atividade) => total + atividade.calorias);

  int get duracaoTotalMinutos => concluidas.fold(
    0,
    (total, atividade) => total + atividade.duracaoMinutos,
  );

  String get tempoTotalFormatado {
    final horas = duracaoTotalMinutos ~/ 60;
    final minutos = duracaoTotalMinutos % 60;
    return '${horas}h${minutos.toString().padLeft(2, '0')}';
  }

  String get nivelAtividade {
    if (totalConcluidas >= 5) {
      return 'Avancado';
    }
    if (totalConcluidas >= 3) {
      return 'Intermediario';
    }
    return 'Iniciante';
  }

  int estimarCalorias(String tipo, int duracaoMinutos) {
    int caloriasPorHora = 120;

    if (tipo == 'Corrida') {
      caloriasPorHora = 180;
    } else if (tipo == 'Caminhada') {
      caloriasPorHora = 120;
    } else if (tipo == 'Musculacao') {
      caloriasPorHora = 240;
    } else if (tipo == 'Alongamento') {
      caloriasPorHora = 60;
    } else if (tipo == 'Yoga') {
      caloriasPorHora = 90;
    }

    return ((caloriasPorHora / 60) * duracaoMinutos).round();
  }

  void adicionarAtividade({
    required String tipo,
    required TimeOfDay horarioInicial,
    required int duracaoMinutos,
  }) {
    final horario = _montarHorario(horarioInicial, duracaoMinutos);

    _atividades.add(
      AtividadeModel(
        nome: tipo,
        icone: _iconeAtividade(tipo),
        horario: horario,
        calorias: estimarCalorias(tipo, duracaoMinutos),
        duracaoMinutos: duracaoMinutos,
      ),
    );

    notifyListeners();
  }

  void concluirAtividade(AtividadeModel atividade) {
    if (atividade.concluida) {
      return;
    }

    atividade.concluida = true;
    atividade.dataConclusao = DateTime.now();
    notifyListeners();
  }

  void reabrirAtividade(AtividadeModel atividade) {
    if (!atividade.concluida) {
      return;
    }

    atividade.concluida = false;
    atividade.dataConclusao = null;
    notifyListeners();
  }

  void resetarProgresso() {
    for (final atividade in _atividades) {
      atividade.concluida = false;
      atividade.dataConclusao = null;
    }
    notifyListeners();
  }

  IconData _iconeAtividade(String tipo) {
    if (tipo == 'Corrida') {
      return Icons.directions_run;
    }
    if (tipo == 'Caminhada') {
      return Icons.directions_walk;
    }
    if (tipo == 'Musculacao') {
      return Icons.fitness_center;
    }
    if (tipo == 'Alongamento') {
      return Icons.self_improvement;
    }
    return Icons.spa_outlined;
  }

  String _montarHorario(TimeOfDay horarioInicial, int duracaoMinutos) {
    final inicioMinutos = horarioInicial.hour * 60 + horarioInicial.minute;
    final fimMinutos = inicioMinutos + duracaoMinutos;

    final horaInicial = horarioInicial.hour.toString().padLeft(2, '0');
    final minutoInicial = horarioInicial.minute.toString().padLeft(2, '0');
    final horaFinal = ((fimMinutos ~/ 60) % 24).toString().padLeft(2, '0');
    final minutoFinal = (fimMinutos % 60).toString().padLeft(2, '0');

    return '$horaInicial:$minutoInicial - $horaFinal:$minutoFinal';
  }
}
