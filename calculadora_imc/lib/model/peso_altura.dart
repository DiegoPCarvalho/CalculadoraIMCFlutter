import 'package:flutter/material.dart';

class PesoAltura {
  final String _id = UniqueKey().toString();
  double _peso = 0;
  double _altura = 0;
  double _resultado = 0;

  PesoAltura(this._peso, this._altura, this._resultado);

  String get id => _id;

  double get peso => _peso;

  double get altura => _altura;

  double get resultado => _resultado;

  void setPeso(peso) {
    _peso = peso;
  }

  void setAltura(altura) {
    _altura = altura;
  }

  void setResultado(resultado) {
    _resultado = resultado;
  }
}
