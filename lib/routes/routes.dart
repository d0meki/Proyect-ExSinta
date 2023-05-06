import 'package:proy_sistemas_expertos/pages/crear_variable_valor.dart';
import 'package:proy_sistemas_expertos/pages/edit_rule.dart';
import 'package:proy_sistemas_expertos/pages/edit_variable_number.dart';
import 'package:proy_sistemas_expertos/pages/edit_variable_scalar.dart';
import 'package:proy_sistemas_expertos/pages/list_rules.dart';
import 'package:proy_sistemas_expertos/pages/list_variable.dart';
import 'package:flutter/material.dart';
import 'package:proy_sistemas_expertos/pages/new_rule.dart';
import 'package:proy_sistemas_expertos/pages/new_variable_number.dart';
import 'package:proy_sistemas_expertos/pages/new_variable_scalar.dart';
import 'package:proy_sistemas_expertos/pages/ver_regla.dart';

class Routes {
  static const initialRoute = 'list_rules';
  static final Map<String, Widget Function(BuildContext)> routes = {
    'list_rules': (BuildContext context) => const ListRules(),
    'list_variable': (BuildContext context) =>const ListVariable(),
    'new_variable_scalar': (BuildContext context) => NewVariableScalar(),
    'new_variable_number': (BuildContext context) => NewVariableNumber(),
    'edit_variable_scalar': (BuildContext context) => EditVariableScalar(),
    'edit_variable_number': (BuildContext context) => EditVariableNumber(),
    'new_rule': (BuildContext context) => NewRule(),
    'ver_rule': (BuildContext context) => const VerRegla(),
    'crear_variable_valor': (BuildContext context) => CrearVariableValor(),
    'edit_rule': (BuildContext context) => EditRule(),
  };
  static final routesName = {
    'list_rules': 'list_rules',
    'list_variable': 'list_variable',
    'new_variable_scalar': 'new_variable_scalar',
    'new_variable_number': 'new_variable_number',
    'edit_variable_scalar': 'new_variable_number',
    'edit_variable_number': 'edit_variable_number',
    'new_rule': 'new_rule',
    'ver_rule': 'ver_rule',
    'crear_variable_valor': 'crear_variable_valor',
    'edit_rule': 'edit_rule',
  };
}
