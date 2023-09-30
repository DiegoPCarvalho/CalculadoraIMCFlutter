import 'package:calculadora_imc/model/peso_altura.dart';

class PesoAlturaRepository {
  final List<PesoAltura> _pesoAltura = [];

  Future<void> adicionar(PesoAltura pesoAltura) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _pesoAltura.add(pesoAltura);
  }

  Future<List<PesoAltura>> listarCalculo() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _pesoAltura;
  }
}
