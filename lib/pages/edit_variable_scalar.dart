import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_sistemas_expertos/pages/crear_variable_valor.dart';
import 'package:proy_sistemas_expertos/provider/base_conocimiento_provider.dart';
import 'package:proy_sistemas_expertos/provider/formulario_provider.dart';
import 'package:proy_sistemas_expertos/utils/util_uno.dart';

class EditVariableScalar extends StatelessWidget {
  final TextEditingController _variableController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  EditVariableScalar({super.key});
  @override
  Widget build(BuildContext context) {
    final baseConocimientoProvider = context.watch<BaseConocimientoProvider>();
    final formularioProvider = context.watch<FormularioProvider>();
    return Scaffold(
      appBar: AppBar(
        title:
            Text("EDITAR VARIABLE ESCALAR \n ${formularioProvider.variableId}"),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              child: const Icon(Icons.home),
              onTap: () {
                //  formularioProvider.limpiarFormulario();
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
                      Text(
                        formularioProvider.variable,style: const TextStyle(
                              color: Colors.black, fontSize: 20)
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
                          child: GestureDetector(
                            child: Text(
                              formularioProvider.valores[index],
                              style: index == formularioProvider.posicion
                                  ? const TextStyle(color: Colors.red)
                                  : const TextStyle(color: Colors.black),
                            ),
                            onTap: () {
                              formularioProvider.setPosicion(index);
                            },
                          ),
                        );
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
                    const Icon(Icons.data_array_outlined),
                    "Valor",
                    TextInputType.name, validateTextFormField: (String value) {
                  if (value.isEmpty) return "Escriba su valor por favor";
                  return null;
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_valorController.text.isNotEmpty &&
                            _variableController.text.isNotEmpty) {
                          formularioProvider.setFormulario(
                              _variableController.text, _valorController.text);
                          _valorController.text = '';
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
                      onPressed: () {
                        if (formularioProvider.valores.isNotEmpty) {
                          formularioProvider.quitarValor();
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
                        'Quitar Valor',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // devuelve el widget del diálogo
                            return AlertDialog(
                              title: const Text('Alert'),
                              content: const Text(
                                  'Los cambios Afectaran a todas las reglas donde se está usando esta variable'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    baseConocimientoProvider.editVariableScalar(
                                        formularioProvider.variable,
                                        formularioProvider.valores,
                                        formularioProvider.variableId);
                                    formularioProvider.limpiarFormulario();
                                    Navigator.pushNamed(
                                        context, 'list_variable');
                                  },
                                  child: const Text('Aceptar'),
                                ),
                              ],
                            );
                          },
                        );
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
