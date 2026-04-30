import 'package:flutter/material.dart';

class NavegacaoController extends ChangeNotifier {
  int indiceAtual = 0;

  void alterarIndice(int indice) {
    indiceAtual = indice;
    notifyListeners();
  }
}
