import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_sistemas_expertos/provider/base_conocimiento_provider.dart';
import 'package:proy_sistemas_expertos/provider/formulario_provider.dart';
import 'package:proy_sistemas_expertos/utils/util_uno.dart';

class CrearVariableValor extends StatelessWidget {
  final TextEditingController _variableController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  CrearVariableValor({super.key});

  @override
  Widget build(BuildContext context) {
    final baseConocimientoProvider = context.watch<BaseConocimientoProvider>();
    final formularioProvider = context.watch<FormularioProvider>();
   
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("VARIABLES"),
      ),
      body: Column(
        children: [
          Flexible(
              child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            padding: const EdgeInsets.only(left: 16, right: 16),
            crossAxisSpacing: 15,
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: RadioListTile(
                  title: const Text('Escalar'),
                  value: true,
                  groupValue: formularioProvider.model.escalar,
                  onChanged: (value) {
                    formularioProvider.setEscalar();
                    FocusScope.of(context).unfocus();
                    _valorController.text = '';
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: RadioListTile(
                  title: const Text('Numerica'),
                  value: true,
                  groupValue: formularioProvider.model.numerico,
                  onChanged: (value) {
                    formularioProvider.setNumerico();
                    FocusScope.of(context).unfocus();
                    _valorController.text = '';
                    formularioProvider.valores = [];
                  },
                ),
              ),
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
                    (formularioProvider.model.escalar)
                        ? const Icon(Icons.data_array_outlined)
                        : const Icon(Icons.numbers_sharp),
                    "Valor",
                    (formularioProvider.model.escalar)
                        ? TextInputType.name
                        : TextInputType.number,
                    validateTextFormField: (String value) {
                  if (value.isEmpty) return "Escriba su valor por favor";
                  return null;
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_valorController.text.isNotEmpty &&
                              _variableController.text.isNotEmpty) {
                            if (formularioProvider.model.escalar) {
                              formularioProvider.setFormulario(
                                  _variableController.text,
                                  _valorController.text);
                            } else {
                              formularioProvider.setFormularioNumber(
                                  _variableController.text,
                                  _valorController.text);
                            }
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
                    ),
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (formularioProvider.valores.isNotEmpty) {
                            formularioProvider.quitarValor();
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // devuelve el widget del diálogo
                              return const VacioAlert();
                              },
                            );
                          }
                        },
                        child: const Text(
                          'Quitar Valor',
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formularioProvider.variable.isNotEmpty) {
                            if (formularioProvider.model.escalar) {
                              baseConocimientoProvider.addNewVariableScalar(
                                  formularioProvider.variable,
                                  formularioProvider.valores);
                            }
                            if (formularioProvider.model.numerico) {
                              baseConocimientoProvider.addNewVariableNumber(
                                  formularioProvider.variable,
                                  formularioProvider.valores);
                            }
                          }
                          formularioProvider.limpiarFormulario();
                          Navigator.pushNamed(context, 'list_variable');
                        },
                        child: const Text(
                          'Guardar',
                        ),
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

class SinValores extends StatelessWidget {
  const SinValores({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: const Text('No puede añadir espacio vacios'),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}

class VacioAlert extends StatelessWidget {
  const VacioAlert({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: const Text('No Existen valores para quitar'),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
