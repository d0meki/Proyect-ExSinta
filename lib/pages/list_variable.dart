import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_sistemas_expertos/provider/base_conocimiento_provider.dart';
import 'package:proy_sistemas_expertos/provider/formulario_provider.dart';

class ListVariable extends StatelessWidget {
  const ListVariable({super.key});
  @override
  Widget build(BuildContext context) {
    final baseConocimientoProvider = context.watch<BaseConocimientoProvider>();
    final formularioProvider = context.watch<FormularioProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Variables'),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              child: const Icon(Icons.home),
              onTap: () {
                Navigator.pushNamed(context, 'list_rules');
              },
            ),
          )
        ],
      ),
      body: (baseConocimientoProvider.baseConocimiento.variables.isNotEmpty)
          ? ListView.builder(
              itemCount:
                  baseConocimientoProvider.baseConocimiento.variables.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(baseConocimientoProvider
                        .baseConocimiento.variables[index].variable),
                    subtitle: Text(baseConocimientoProvider
                        .baseConocimiento.variables[index].valor
                        .toString()),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DialogoPersonal(
                              baseConocimientoProvider:
                                  baseConocimientoProvider,
                              posicion: index,
                            );
                          });
                    },
                  ),
                );
              },
            )
          : const Center(
              child: Text("No Existe Variables para mostrar"),
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              // showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return const OtroDialog();
              //     });
              formularioProvider.limpiarFormulario();
              Navigator.pushNamed(context, 'crear_variable_valor');
            },
            label: const Text('Nueva Variable'),
            icon: const Icon(Icons.add_circle_outline),
            backgroundColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}

class OtroDialog extends StatelessWidget {
  const OtroDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text(
                'ESCOJA EL TIPO DE VARIABLE',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'new_variable_scalar');
                    },
                    child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/img/multivalue.jpg',
                                height: 60,
                                width: 60,
                              ),
                              const Text('Multivalor'),
                            ],
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'new_variable_number');
                      // choceImageCamare();
                    },
                    child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/img/numerico.jpg',
                                height: 60,
                                width: 60,
                              ),
                              const Text('Numerico'),
                            ],
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DialogoPersonal extends StatelessWidget {
  const DialogoPersonal(
      {Key? key,
      required this.baseConocimientoProvider,
      required this.posicion})
      : super(key: key);

  final BaseConocimientoProvider baseConocimientoProvider;
  final int posicion;

  @override
  Widget build(BuildContext context) {
    final formularioProvider = context.watch<FormularioProvider>();
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text(
                'OPCIONES',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      final tipoValor = baseConocimientoProvider
                          .baseConocimiento.variables[posicion].tipoValor;

                      if (tipoValor == 'numerico') {
                        formularioProvider.cargarFormulario(
                            baseConocimientoProvider
                                .baseConocimiento.variables[posicion].variable,
                            baseConocimientoProvider
                                .baseConocimiento.variables[posicion].valor,
                            baseConocimientoProvider.baseConocimiento
                                .variables[posicion].variableId);
                        baseConocimientoProvider.setPosicion(posicion);
                        Navigator.pushNamed(context, 'edit_variable_number');
                      } else {
                        formularioProvider.cargarFormulario(
                            baseConocimientoProvider
                                .baseConocimiento.variables[posicion].variable,
                            baseConocimientoProvider
                                .baseConocimiento.variables[posicion].valor,
                            baseConocimientoProvider.baseConocimiento
                                .variables[posicion].variableId);
                        baseConocimientoProvider.setPosicion(posicion);

                        Navigator.pushNamed(context, 'edit_variable_scalar');
                      }
                    },
                    child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/img/edit.png',
                                height: 60,
                                width: 60,
                              ),
                              const Text('Editar'),
                            ],
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // devuelve el widget del diálogo
                          return AlertDialog(
                            title: const Text('Alert'),
                            content: const Text(
                                'Eliminar una Variable implica eliminar todas las reglas donde se usó, esta seguro?'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  baseConocimientoProvider.deLeteVariable(
                                      posicion,
                                      baseConocimientoProvider.baseConocimiento
                                          .variables[posicion].variableId);
                                  Navigator.pushNamed(context, 'list_rules');
                                },
                                child: const Text('Aceptar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/img/delete.png',
                                height: 60,
                                width: 60,
                              ),
                              const Text('Eliminar'),
                            ],
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
