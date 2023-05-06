// To parse this JSON data, do
//
//     final baseConocimiento = baseConocimientoFromJson(jsonString);
import 'dart:convert';

BaseConocimiento baseConocimientoFromJson(String str) =>
    BaseConocimiento.fromJson(json.decode(str));

String baseConocimientoToJson(BaseConocimiento data) =>
    json.encode(data.toJson());

class BaseConocimiento {
  List<Regla> reglas;
  List<Variable> variables;

  BaseConocimiento({
    required this.reglas,
    required this.variables,
  });

  factory BaseConocimiento.fromJson(Map<String, dynamic> json) =>
      BaseConocimiento(
        reglas: List<Regla>.from(json["reglas"].map((x) => Regla.fromJson(x))),
        variables: List<Variable>.from(
            json["variables"].map((x) => Variable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reglas": List<dynamic>.from(reglas.map((x) => x.toJson())),
        "variables": List<dynamic>.from(variables.map((x) => x.toJson())),
      };
}

class Regla {
  String nombre;
  Premisa premisa;
  List<Hecho> hecho;

  Regla({
    required this.nombre,
    required this.premisa,
    required this.hecho,
  });

  factory Regla.fromJson(Map<String, dynamic> json) => Regla(
        nombre: json["nombre"],
        premisa: Premisa.fromJson(json["premisa"]),
        hecho: List<Hecho>.from(json["hecho"].map((x) => Hecho.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "premisa": premisa.toJson(),
        "hecho": List<dynamic>.from(hecho.map((x) => x.toJson())),
      };
}

class Hecho {
  final String variableId;
  String variable;
  late String valor;

  Hecho({
    required this.variableId,
    required this.variable,
    required this.valor,
  });

  factory Hecho.fromJson(Map<String, dynamic> json) => Hecho(
        variableId: json["variable_id"],
        variable: json["variable"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "variable_id": variableId,
        "variable": variable,
        "valor": valor,
      };
}

class Premisa {
  List<Literal> literal;

  Premisa({
    required this.literal,
  });

  factory Premisa.fromJson(Map<String, dynamic> json) => Premisa(
        literal:
            List<Literal>.from(json["literal"].map((x) => Literal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "literal": List<dynamic>.from(literal.map((x) => x.toJson())),
      };
}

class Literal {
  final String variableId;
  String variable;
  String valor;
  String operadorLogico;
  bool not;

  Literal({
    required this.variableId,
    required this.variable,
    required this.valor,
    required this.operadorLogico,
    required this.not,
  });

  factory Literal.fromJson(Map<String, dynamic> json) => Literal(
        variableId: json["variable_id"],
        variable: json["variable"],
        valor: json["valor"],
        operadorLogico: json["operador_logico"],
        not: json["not"],
      );

  Map<String, dynamic> toJson() => {
        "variable_id": variableId,
        "variable": variable,
        "valor": valor,
        "operador_logico": operadorLogico,
        "not": not,
      };
}

class Variable {
  final String variableId;
  String variable;
  List<String> valor;
  String tipoValor;

  Variable({
    required this.variableId,
    required this.variable,
    required this.valor,
    required this.tipoValor,
  });

  factory Variable.fromJson(Map<String, dynamic> json) => Variable(
        variableId: json["variable_id"],
        variable: json["variable"],
        valor: List<String>.from(json["valor"].map((x) => x)),
        tipoValor: json["tipo_valor"],
      );

  Map<String, dynamic> toJson() => {
        "variable_id": variableId,
        "variable": variable,
        "valor": List<dynamic>.from(valor.map((x) => x)),
        "tipo_valor": tipoValor,
      };
}
