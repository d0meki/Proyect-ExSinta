import 'package:flutter/cupertino.dart';
import 'package:proy_sistemas_expertos/archivos/archivos.dart';
import 'package:proy_sistemas_expertos/model/base_conocimiento.dart';
import 'package:uuid/uuid.dart';

class BaseConocimientoProvider with ChangeNotifier {
  late BaseConocimiento baseConocimiento =
      BaseConocimiento(reglas: [], variables: []);
  String nameFile = "";
  List<String> listaArchivos = [];
  final Archivos _archivos = Archivos();
  int posicion = -1;
  int reglaPosicion = -1;
  double tamanioDialog = 100.0;

  Future<void> setBaseConocimiento(String namaArchivo) async {
    nameFile = namaArchivo;
    baseConocimiento = await _archivos.readLocalFile(namaArchivo);
    notifyListeners();
  }

  Future<void> setPosicion(int posicion) async {
    this.posicion = posicion;
    notifyListeners();
  }

  Future<void> setNuevaBaseConocimiento(String namaArchivo) async {
    final BaseConocimiento nuevaBase =
        BaseConocimiento(reglas: [], variables: []);
    final String baseJason = baseConocimientoToJson(nuevaBase);
    final escribir =
        await _archivos.writeLocalFile(baseJason, '$namaArchivo.bcm');
    if (escribir) {
      baseConocimiento = await _archivos.readLocalFile('$namaArchivo.bcm');
      nameFile = '$namaArchivo.bcm';
    } else {
      // ignore: avoid_print
      print("Error algo susecdio");
    }
    baseConocimiento = await _archivos.readLocalFile('$namaArchivo.bcm');
    notifyListeners();
  }

  Future<void> getListArchivos() async {
    listaArchivos = await _archivos.getListDir();
    if (listaArchivos.length > 8 || tamanioDialog > 600.0) {
      tamanioDialog = 600.0;
    } else {
      tamanioDialog = 100.0 * listaArchivos.length;
    }
    notifyListeners();
  }

  Future<void> addNewVariableScalar(
      String variable, List<String> valores) async {
    String variableId = const Uuid().v1();
    final Variable nuevaVariable = Variable(
        variable: variable,
        valor: valores,
        tipoValor: "escalar",
        variableId: variableId);
    baseConocimiento.variables.add(nuevaVariable);
    final nuevaData = baseConocimientoToJson(baseConocimiento);
    final escribir = await _archivos.writeLocalFile(nuevaData, nameFile);
    if (escribir) {
      // ignore: avoid_print
      print('se registró la nueva Variable');
      baseConocimiento = await _archivos.readLocalFile(nameFile);
    } else {
      // ignore: avoid_print
      print('no se registró la nueva Variable');
    }
    notifyListeners();
  }

  Future<void> deLeteVariable(int posicion, String variableId) async {
    int currentIndex = 0;
    while (currentIndex < baseConocimiento.reglas.length) {
      List<Literal> temporalListLiteral = baseConocimiento
          .reglas[currentIndex].premisa.literal
          .where((lit) => lit.variableId == variableId)
          .toList();
      List<Hecho> tempHecho = baseConocimiento.reglas[currentIndex].hecho
          .where((hec) => hec.variableId == variableId)
          .toList();
      if (temporalListLiteral.isNotEmpty || tempHecho.isNotEmpty) {
        baseConocimiento.reglas.removeAt(currentIndex);
        currentIndex = 0;
      } else {
        currentIndex++;
      }
    }
    baseConocimiento.variables.removeAt(posicion);
    final nuevaData = baseConocimientoToJson(baseConocimiento);
    final escribir = await _archivos.writeLocalFile(nuevaData, nameFile);
    if (escribir) {
      // ignore: avoid_print
      print('Eliminado');
      baseConocimiento = await _archivos.readLocalFile(nameFile);
    } else {
      // ignore: avoid_print
      print('No se pudo Eliminar');
    }
    notifyListeners();
  }

  Future<void> editVariableScalar(
      String variable, List<String> valores, String variableId) async {
    final Variable nuevaVariable = Variable(
        variable: variable,
        valor: valores,
        tipoValor: "escalar",
        variableId: variableId);
    for (Regla regla in baseConocimiento.reglas) {
      //TODO: modifica los valores de los literales de la premisa
      List<Literal> temporalListLiteral = regla.premisa.literal
          .where((lit) => lit.variableId == variableId)
          .toList();
      for (Literal lite in temporalListLiteral) {
        lite.valor = 'SIN';
      }
      //TODO: modifica el Velor del hecho
      Hecho tempHecho =
          regla.hecho.firstWhere((hec) => hec.variableId == variableId);
      tempHecho.valor = 'SIN';
    }
    baseConocimiento.variables[posicion] = nuevaVariable;
    final nuevaData = baseConocimientoToJson(baseConocimiento);
    final escribir = await _archivos.writeLocalFile(nuevaData, nameFile);
    if (escribir) {
      // ignore: avoid_print
      print('se registró la nueva Variable');
      baseConocimiento = await _archivos.readLocalFile(nameFile);
    } else {
      // ignore: avoid_print
      print('no se registró la nueva Variable');
    }
    notifyListeners();
  }

  Future<void> editVariableNumber(
      String variable, List<String> valores, String variableId) async {
    final Variable nuevaVariable = Variable(
        variable: variable,
        valor: valores,
        tipoValor: "numerico",
        variableId: variableId);
    for (Regla regla in baseConocimiento.reglas) {
      //TODO: modifica los valores de los literales de la premisa
      List<Literal> temporalListLiteral = regla.premisa.literal
          .where((lit) => lit.variableId == variableId)
          .toList();
      for (Literal lite in temporalListLiteral) {
        lite.valor = valores[0];
      }

      //TODO: modifica el Velor del hecho
      Hecho tempHecho =
          regla.hecho.firstWhere((hec) => hec.variableId == variableId);
      tempHecho.valor = valores[0];
    }
    baseConocimiento.variables[posicion] = nuevaVariable;
    final nuevaData = baseConocimientoToJson(baseConocimiento);
    final escribir = await _archivos.writeLocalFile(nuevaData, nameFile);
    if (escribir) {
      // ignore: avoid_print
      print('se registró la nueva Variable');
      baseConocimiento = await _archivos.readLocalFile(nameFile);
    } else {
      // ignore: avoid_print
      print('no se registró la nueva Variable');
    }
    notifyListeners();
  }

  Future<void> addNewVariableNumber(
      String variable, List<String> valores) async {
    String variableId = const Uuid().v1();
    final Variable nuevaVariable = Variable(
        variable: variable,
        valor: valores,
        tipoValor: "numerico",
        variableId: variableId);
    baseConocimiento.variables.add(nuevaVariable);
    final nuevaData = baseConocimientoToJson(baseConocimiento);
    final escribir = await _archivos.writeLocalFile(nuevaData, nameFile);
    if (escribir) {
      // ignore: avoid_print
      print('se registró la nueva Variable');
      baseConocimiento = await _archivos.readLocalFile(nameFile);
    } else {
      // ignore: avoid_print
      print('no se registró la nueva Variable');
    }
    notifyListeners();
  }

  Future<void> addNewRegla(String nombreRegla, List<Literal> listLiteral,
      List<Hecho> listHecho) async {
    late Premisa premisa = Premisa(literal: listLiteral);
    late Regla regla =
        Regla(nombre: nombreRegla, premisa: premisa, hecho: listHecho);
    baseConocimiento.reglas.add(regla);
    final nuevaData = baseConocimientoToJson(baseConocimiento);
    final escribir = await _archivos.writeLocalFile(nuevaData, nameFile);
    if (escribir) {
      // ignore: avoid_print
      print('se registró la nueva Regla');
      baseConocimiento = await _archivos.readLocalFile(nameFile);
    } else {
      // ignore: avoid_print
      print('no se registró la nueva Regla');
    }
    notifyListeners();
  }

  Future<void> updateRegla(String nombreRegla, List<Literal> listLiteral,
      List<Hecho> listHecho) async {
    late Premisa premisa = Premisa(literal: listLiteral);
    late Regla regla =
        Regla(nombre: nombreRegla, premisa: premisa, hecho: listHecho);
    baseConocimiento.reglas[reglaPosicion] = regla;
    final nuevaData = baseConocimientoToJson(baseConocimiento);
    final escribir = await _archivos.writeLocalFile(nuevaData, nameFile);
    if (escribir) {
      // ignore: avoid_print
      print('se registró la nueva Regla');
      baseConocimiento = await _archivos.readLocalFile(nameFile);
    } else {
      // ignore: avoid_print
      print('no se registró la nueva Regla');
    }
    notifyListeners();
  }

  Future<void> deLeteRegla(int posicion) async {
    baseConocimiento.reglas.removeAt(posicion);
    final nuevaData = baseConocimientoToJson(baseConocimiento);
    final escribir = await _archivos.writeLocalFile(nuevaData, nameFile);
    if (escribir) {
      // ignore: avoid_print
      print('Eliminado');
      baseConocimiento = await _archivos.readLocalFile(nameFile);
    } else {
      // ignore: avoid_print
      print('No se pudo Eliminar');
    }
    notifyListeners();
  }

  Future<void> setReglaPosicion(int reglaPosicion) async {
    this.reglaPosicion = reglaPosicion;
    notifyListeners();
  }
}
