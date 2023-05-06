import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_sistemas_expertos/pages/crear_variable_valor.dart';
import 'package:proy_sistemas_expertos/provider/base_conocimiento_provider.dart';
import 'package:proy_sistemas_expertos/provider/formulario_provider.dart';
import 'package:proy_sistemas_expertos/utils/util_uno.dart';

class EditVariableNumber extends StatelessWidget {
  final TextEditingController _variableController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  EditVariableNumber({super.key});
  @override
  Widget build(BuildContext context) {
    final baseConocimientoProvider = context.watch<BaseConocimientoProvider>();
    final formularioProvider = context.watch<FormularioProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "EDITAR VARIABLE NUMERICO \n ${formularioProvider.variableId}"),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              child: const Icon(Icons.home),
              onTap: () {
                // formularioProvider.limpiarFormulario();
                Navigator.pushNamed(context, 'list_rules');
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Flexible(
              child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            padding: const EdgeInsets.only(left: 16, right: 16),
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            children: [
              Container(
                decoration: BoxDecoration(
                  // color: Color(0xff392850),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.white,
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(formularioProvider.variable,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20)),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  // color: Color(0xff392850),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.white,
                    elevation: 4,
                    child: Center(
                      child: Text(formularioProvider.valores[0],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20)),
                    )),
              )
            ],
          )),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
                child: Column(
              children: [
                CustomTextFormField(
                    _variableController,
                    const Icon(Icons.abc_rounded),
                    "Variable",
                    TextInputType.name, validateTextFormField: (String value) {
                  if (value.isEmpty) return "Escriba la variable por favor";
                  return null;
                }),
                CustomTextFormField(
                    _valorController,
                    const Icon(Icons.numbers_sharp),
                    "Valor",
                    TextInputType.number,
                    validateTextFormField: (String value) {
                  if (!Validation.soloNumeros(_valorController.text)) {
                    return "Solo se permite números";
                  }
                  return null;
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_valorController.text.isNotEmpty &&
                            _variableController.text.isNotEmpty) {
                          formularioProvider.setFormularioNumber(
                              _variableController.text, _valorController.text);
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // devuelve el widget del diálogo
                              return const SinValores();
                            },
                          );
                        }
                      },
                      child: const Text(
                        'Agregar Valor',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        baseConocimientoProvider.editVariableNumber(
                            formularioProvider.variable,
                            formularioProvider.valores,
                            formularioProvider.variableId);
                        formularioProvider.limpiarFormulario();
                        Navigator.pushNamed(context, 'list_variable');
                      },
                      child: const Text(
                        'Guardar Cambios',
                      ),
                    ),
                  ],
                )
              ],
            )),
          )),
        ],
      ),
    );
  }
}
