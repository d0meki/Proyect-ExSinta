import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_sistemas_expertos/provider/base_conocimiento_provider.dart';
import 'package:proy_sistemas_expertos/provider/formulario_provider.dart';
import 'package:proy_sistemas_expertos/utils/util_uno.dart';

class NewVariableNumber extends StatelessWidget {
  final TextEditingController _variableController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  NewVariableNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final baseConocimientoProvider = context.watch<BaseConocimientoProvider>();
    final formularioProvider = context.watch<FormularioProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("NUEVA VARIABLE NUMERICO"),
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
                      Text(
                        formularioProvider.variable,
                      ),
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
                    child: ListView.builder(
                      itemCount: formularioProvider.valores.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: Text(formularioProvider.valores[index]));
                      },
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
              ],
            )),
          )),
          ElevatedButton(
            onPressed: () {
              formularioProvider.setFormularioNumber(
                  _variableController.text, _valorController.text);
              _valorController.text = '';
            },
            child: const Text(
              'Agregar Valor',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              baseConocimientoProvider.addNewVariableNumber(
                  formularioProvider.variable, formularioProvider.valores);
              formularioProvider.limpiarFormulario();
              Navigator.pushNamed(context, 'list_variable');
            },
            child: const Text(
              'Guardar',
            ),
          ),
        ],
      ),
    );
  }
}
