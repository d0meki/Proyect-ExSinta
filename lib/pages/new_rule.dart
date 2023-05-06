import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_sistemas_expertos/model/base_conocimiento.dart';
import 'package:proy_sistemas_expertos/pages/crear_variable_valor.dart';
import 'package:proy_sistemas_expertos/provider/base_conocimiento_provider.dart';
import 'package:proy_sistemas_expertos/provider/formulario_new_regla.dart';

class NewRule extends StatelessWidget {
  final TextEditingController _nombreController = TextEditingController();
  NewRule({super.key});

  @override
  Widget build(BuildContext context) {
    final baseConocimientoProvider = context.watch<BaseConocimientoProvider>();
    final formRegla = context.watch<FormularioNewReglaProvider>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Nueva Regla"),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                child: const Icon(Icons.home),
                onTap: () {
                  formRegla.limpiarTodo();
                  Navigator.pushNamed(context, 'list_rules');
                },
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Text(
                    'IF',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        background: Paint()
                          ..color = (formRegla.ifthen == 0)
                              ? Colors.amber
                              : Colors.white),
                  ),
                  onTap: () {
                    print('AGREGAR LITERAL Y MOSTRAR LITERAL');
                    formRegla.setIfThen(0);
                  },
                ),
              ),
            ),
            Flexible(
              child: Card(
                elevation: 8,
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: formRegla.listLiteral.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(left: 20, top: 5),
                          child: GestureDetector(
                            child: (index > 0 &&
                                    index < formRegla.listLiteral.length)
                                ? Text(
                                    'AND ${formRegla.listLiteral[index].not? 'not ': ''} ${formRegla.listLiteral[index].variable} ${formRegla.listLiteral[index].operadorLogico} ${formRegla.listLiteral[index].valor}',
                                    style: TextStyle(
                                        background: Paint()
                                          ..color =
                                              (formRegla.itemLiteral == index)
                                                  ? Colors.red
                                                  : Colors.white))
                                : Text(
                                    '${formRegla.listLiteral[index].not? 'not ': ''} ${formRegla.listLiteral[index].variable} ${formRegla.listLiteral[index].operadorLogico} ${formRegla.listLiteral[index].valor}',
                                    style: TextStyle(
                                        background: Paint()
                                          ..color =
                                              (formRegla.itemLiteral == index)
                                                  ? Colors.red
                                                  : Colors.white)),
                            onTap: () {
                              formRegla.setIfThen(0);
                              formRegla.setItemLiteral(index);
                            },
                          ));
                    },
                  ),
                ),
              ),
            ),
            Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Text('THEN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          background: Paint()
                            ..color = (formRegla.ifthen == 1)
                                ? Colors.amber
                                : Colors.white)),
                  onTap: () {
                    formRegla.setIfThen(1);
                  },
                ),
              ),
            ),
            Flexible(
              child: Card(
                elevation: 8,
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: formRegla.listHecho.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, top: 5),
                        child: GestureDetector(
                          child: Text(
                              '${formRegla.listHecho[i].variable} = ${formRegla.listHecho[i].valor}',
                              style: TextStyle(
                                  background: Paint()
                                    ..color = (formRegla.itemHecho == i)
                                        ? Colors.red
                                        : Colors.white)),
                          onTap: () {
                            formRegla.setIfThen(1);
                            formRegla.setItemHecho(i);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  child: TextFormField(
                    controller: _nombreController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'Nombre Regla',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                (formRegla.ifthen == 0)
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Container(
                          width: 100,
                          color: Colors.amber,
                          child: CheckboxListTile(
                              title: const Text(
                                '¬',
                                style: TextStyle(fontSize: 50),
                              ),
                              value: formRegla.not,
                              onChanged: (value) {
                                formRegla.setNot();
                              }),
                        ),
                      )
                    : const Center(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text("variable",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(
                      "Operador",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text("Valor",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<String>(
                      key: UniqueKey(),
                      value: formRegla.variable,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(2),
                      focusColor: Colors.blue,
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                      onChanged: (String? newVariable) {
                        formRegla.setVariable(newVariable!);
                        final List<Variable> variable = baseConocimientoProvider
                            .baseConocimiento.variables
                            .where(
                                (variable) => variable.variable == newVariable)
                            .toList();

                        formRegla.setOperadores(variable[0].tipoValor);
                        formRegla.setValores(variable[0].valor);
                        formRegla.setVariableId(variable[0].variableId);
                      },
                      items: baseConocimientoProvider.baseConocimiento.variables
                          .map<DropdownMenuItem<String>>((Variable value) {
                        return DropdownMenuItem<String>(
                          value: value.variable,
                          child: Text(value.variable),
                        );
                      }).toList(),
                    ),
                    DropdownButton<String>(
                      key: UniqueKey(),
                      value: formRegla.operador,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(2),
                      focusColor: Colors.blue,
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                      onChanged: (String? newOperador) {
                        formRegla.setOperador(newOperador!);
                      },
                      items: formRegla.operadores
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    DropdownButton<String>(
                      key: UniqueKey(),
                      value: formRegla.valor,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(2),
                      focusColor: Colors.blue,
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                      onChanged: (String? newvalor) {
                        formRegla.setValor(newvalor!);
                      },
                      items: formRegla.valores
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (formRegla.ifthen == 0) {
                          if (formRegla.variable != null &&
                              formRegla.operador != null &&
                              formRegla.valor != null) {
                            formRegla.setLiteral();
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // devuelve el widget del diálogo

                                return const SinValores();
                              },
                            );
                          }
                        }
                        if (formRegla.ifthen == 1) {
                          if (formRegla.variable != null &&
                              formRegla.operador != null &&
                              formRegla.valor != null) {
                            formRegla.setHecho();
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // devuelve el widget del diálogo

                                return const SinValores();
                              },
                            );
                          }
                        }
                      },
                      child: const Text(
                        'Agregar',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formRegla.ifthen == 0) {
                          if (formRegla.listLiteral.isNotEmpty) {
                            formRegla.removeItemLiteral();
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const VacioAlert();
                              },
                            );
                          }
                        }
                        if (formRegla.ifthen == 1) {
                          if (formRegla.listHecho.isNotEmpty) {
                            formRegla.removeItemHecho();
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const VacioAlert();
                              },
                            );
                          }
                        }
                      },
                      child: const Text(
                        'Quitar',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_nombreController.text.isNotEmpty) {
                          baseConocimientoProvider.addNewRegla(
                              _nombreController.text,
                              formRegla.listLiteral,
                              formRegla.listHecho);
                          formRegla.limpiarTodo();
                          Navigator.pushNamed(context, 'list_rules');
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AvisoTextController();
                            },
                          );
                        }
                      },
                      child: const Text(
                        'Guardar',
                      ),
                    ),
                  ],
                )
              ],
            ))
          ],
        ));
  }
}

class AvisoTextController extends StatelessWidget {
  const AvisoTextController({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: const Text('Debe colocarle un nombre a la Regla'),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
