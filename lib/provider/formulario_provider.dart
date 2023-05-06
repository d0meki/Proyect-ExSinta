import 'package:flutter/material.dart';
import 'package:proy_sistemas_expertos/utils/option_model.dart';

class FormularioProvider with ChangeNotifier {
  // TipoVariable valorTipoVariable = TipoVariable.escalar;
  OptionsModel _model = OptionsModel();

  OptionsModel get model => _model;

  String variable = "";
  String variableId = "";
  List<String> valores = [];
  int posicion = -1;

  Future<void> setEscalar() async {
    _model.selectEscalar();
    notifyListeners();
  }

  Future<void> setNumerico() async {
    _model.selectNumerico();
    notifyListeners();
  }

  Future<void> setFormulario(String variable, String valor) async {
    this.variable = variable;
    valores.add(valor);
    notifyListeners();
  }

  Future<void> cargarFormulario(
      String variable, List<String> valores, String variableId) async {
    this.variable = variable;
    this.valores = valores;
    this.variableId = variableId;
    notifyListeners();
  }

  Future<void> setFormularioNumber(String variable, String valor) async {
    this.variable = variable;
    valores = [];
    valores.add(valor);
    notifyListeners();
  }

  Future<void> limpiarFormulario() async {
    variable = "";
    valores = [];
    notifyListeners();
  }

  Future<void> setPosicion(int posicion) async {
    this.posicion = posicion;
    notifyListeners();
  }

  Future<void> quitarValor() async {
    if (posicion == -1) {
      valores.removeLast();
    } else {
      valores.removeAt(posicion);
      posicion = -1;
    }
    notifyListeners();
  }
}
