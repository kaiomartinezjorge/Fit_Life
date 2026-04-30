import 'package:flutter/material.dart';

class AtividadeModel {
  String nome;
  IconData icone;
  String horario;
  int calorias;
  int duracaoMinutos;
  bool concluida;
  DateTime? dataConclusao;

  AtividadeModel({
    required this.nome,
    required this.icone,
    required this.horario,
    required this.calorias,
    required this.duracaoMinutos,
    this.concluida = false,
    this.dataConclusao,
  });
}
