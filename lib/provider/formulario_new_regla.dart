import 'package:flutter/material.dart';
import 'package:proy_sistemas_expertos/model/base_conocimiento.dart';

class FormularioNewReglaProvider with ChangeNotifier {
  List<Literal> listLiteral = [];
  List<Hecho> listHecho = [];
  // ignore: prefer_typing_uninitialized_variables
  var variable;
  // ignore: prefer_typing_uninitialized_variables
  var operador;
  // ignore: prefer_typing_uninitialized_variables
  var valor;
  String variableId = '';
  List<String> operadores = ['=', '<>', '<', '>', '<=', '>='];
  List<String> valores = [];
  int ifthen = -1;
  int itemHecho = -1;
  int itemLiteral = -1;
  bool not = false;


  Future<void> setOperadores(String tipoVariable) async {
    if (tipoVariable == 'numerico') {
      operadores = ['=', '<>', '<', '>', '<=', '>='];
    } else {
      operadores = ['=', '<>'];
    }
    operador = operadores[0];
    notifyListeners();
  }

  Future<void> setVariable(String variable) async {
    this.variable = variable;
    notifyListeners();
  }

  Future<void> setOperador(String operador) async {
    this.operador = operador;
    notifyListeners();
  }
    Future<void> setVariableId(String variableId) async {
    this.variableId = variableId;
    notifyListeners();
  }

  Future<void> setValor(String valor) async {
    this.valor = valor;
    notifyListeners();
  }

  Future<void> setValores(List<String> valores) async {
    this.valores = [];
    this.valores = valores;
    valor = valores[0];
    notifyListeners();
  }
  Future<void> setNot() async {
    not = !not;
    notifyListeners();
  }

  Future<void> setLiteral() async {
    final Literal literal = Literal(
        variable: variable, valor: valor, operadorLogico: operador, not: not, variableId: variableId);
    listLiteral.add(literal);
    notifyListeners();
  }

  Future<void> setHecho() async {
    final Hecho hecho = Hecho(variable: variable, valor: valor, variableId: variableId);
    listHecho.add(hecho);
    notifyListeners();
  }

  Future<void> setIfThen(int newValue) async {
    ifthen = newValue;
    notifyListeners();
  }

  Future<void> setItemHecho(int itemH) async {
    itemHecho = itemH;
    itemLiteral = -1;
    notifyListeners();
  }

  Future<void> setItemLiteral(int itemL) async {
    itemLiteral = itemL;
    itemHecho = -1;
    notifyListeners();
  }

  Future<void> removeItemLiteral() async {
    listLiteral.removeAt(itemLiteral);
    itemLiteral = -1;
    notifyListeners();
  }

  Future<void> removeItemHecho() async {
    listHecho.removeAt(itemHecho);
    itemHecho = -1;
    notifyListeners();
  }

  Future<void> limpiarTodo() async {
    listLiteral = [];
    listHecho = [];
    valores = [];
    ifthen = -1;
    itemHecho = -1;
    itemLiteral = -1;
    variableId = '';
    notifyListeners();
  }
}
