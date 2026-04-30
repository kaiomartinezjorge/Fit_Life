import 'package:flutter/material.dart';

import '../models/configuracao_model.dart';

class ConfiguracaoController extends ChangeNotifier {
  final ConfiguracaoModel model = ConfiguracaoModel(
    temaEscuro: false,
    nomeUsuario: 'Usuario',
    metaSemanal: 4,
  );

  void alternarTema(bool valor) {
    model.temaEscuro = valor;
    notifyListeners();
  }

  void atualizarNome(String nome) {
    final nomeTratado = nome.trim();
    if (nomeTratado.isEmpty) {
      return;
    }

    model.nomeUsuario = nomeTratado;
    notifyListeners();
  }

  void atualizarMeta(int meta) {
    model.metaSemanal = meta.clamp(1, 14);
    notifyListeners();
  }
}
